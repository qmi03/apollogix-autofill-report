= Extraction Chain
Ghép tất cả thành kiến trúc học tăng cường.
```python
from langchain.prompts import ChatPromptTemplate
from pydantic import BaseModel
from pydantic_dynamic_model import ModelDefinition, create_dynamic_model
from src.db.main import get
from src.lib.example import Example, tool_example_to_messages
from src.lib.models import groq_chatmodel as default_chat_model
from src.lib.prompts import PromptDefinition, create_dynamic_messages

def default_chain():
    prompts_definition = get("prompt")
    schema_definition = get("schema")

    parsed_prompts_definition = PromptDefinition.model_validate(prompts_definition)
    parsed_schema_definition = ModelDefinition.model_validate(schema_definition)

    prompt = ChatPromptTemplate.from_messages(
        create_dynamic_messages(parsed_prompts_definition, need_examples)
    )
    schema = create_dynamic_model(parsed_schema_definition)

    chain = prompt | default_chat_model.with_structured_output(schema=schema)

    return chain
```
Sau đó người dùng có thể gọi bằng cách truyền dữ liệu không cấu trúc như sau:
```python
input = get_input()
chain = default_chain()
output = chain.invoke({"input" = input})
```
