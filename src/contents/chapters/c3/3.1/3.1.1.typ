= Prompt

== Prompt cơ bản

```python
from langchain_core.messages import SystemMessage
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from pydantic import BaseModel

messages = [
    SystemMessage(
        content="Extract shipping job details from PDF text. "
        "If any value is missing, return default value. "
        "Use field descriptions for guidance, and please use enum values "
        "if provided",
    ),
    ("human", "This is what you have to extract from: {context}")
]
simple_extraction_prompt = ChatPromptTemplate.from_messages(messages)
```

== Prompt thực tế
Dùng hàm `create_dynamic_messages()` để tạo prompt trong Runtime một cách linh
hoạt. Cho phép người dùng thay đổi prompt mà không cần phải ngưng server để sửa
mã nguồn và chạy lại. Bên cạnh đó, người dùng sẽ thêm những lời hướng dẫn (tips)
cho mô hình trở nên thông minh hơn.

```python
from langchain_core.messages import HumanMessage, SystemMessage
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from pydantic import BaseModel


class PromptDefinition(BaseModel):
    system: str
    tips: list[str]


def create_dynamic_messages(
    prompt_definition: PromptDefinition, need_examples: bool = False
) -> ChatPromptTemplate:
    messages = [
        SystemMessage(content=prompt_definition.system),
    ]
    messages.extend(
        [HumanMessage(content=f"Tips: {tip}") for tip in prompt_definition.tips]
    )
    if need_examples:
        messages.append(MessagesPlaceholder("examples"))
    messages.append(("human", "This is what you have to extract: {context}"))

    return messages
```
từ đây ta có thể chỉnh sửa file `prompts.json` như sau:
```json
{
  "system": "Extract shipping job details from PDF text. If any value is missing, return default value. Use field descriptions for guidance, and please use enum values if provided.",
  "tips": [
    "If a job lacks an ETD, it’s likely IMPORT/RAIL_INBOUND; if it lacks an ETA, it’s likely EXPORT/RAIL_OUTBOUND. A job with rail info is a RAIL job. If unsure, use IMPORT",
    "vessel and voyage often go together, first part is vessel name and second part is voyage code",
    "Use datetime format YYYY-MM-DD for dates, timezone should be in UTC",
    "Container weights often include only grossWeight, but, it can sometimes include netWeight or tareWeight, or both. Formula: netWeight = grossWeight - tareWeight."
  ]
}
```
Mô hình sẽ đọc file `prompts.json` và gọi hàm `create_dynamic_messages()`:
```python
from json import load
prompts_definition = load("prompts.json")
parsed_prompts_definition = PromptDefinition.model_validate(prompts_definition)
prompt = ChatPromptTemplate.from_messages(
    create_dynamic_messages(parsed_prompts_definition, need_examples)
)
```
