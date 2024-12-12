= Schema
Yêu cầu output có kết quả như sau:
```json
{
  "jobType": "IMPORT",
  "shipmentType": "FCL",
  "referenceNumber": "string",
  "vessel": "string",
  "voyage": "string",
  "etd": "2024-06-11T10:25:40.834Z",
  "eta": "2024-06-11T10:25:40.834Z",
  "agentClient": "string",
  "consignClient": "string",
  "warehouseClient": "string",
  "accountReceivableClient": "string",
  "jobContainers": [
    {
      "containerNumber": "string",
      "sealNumber": "string",
      "tare": 0,
      "net": 0,
      "grossWeight": 0,
      "doorType": "string",
      "dropMode": "string",
      "containerSize": "string"
    }
  ]
}
```
== Schema cơ bản
Ta có thể định nghĩa một schema cố định như sau:
```python
from pydantic import BaseModel, Field
class Container(BaseModel):
    containerNumber: Optional[str] = Field(default=None, description="")
    sealNumber: Optional[str] = Field(default=None, description="")
    dropMode: Optional[str] = Field(
        default=None,
        description="",
        enum=[
            "Sideloader Wait Unpacking/Packing",
            "Standard Trailer-Drop Trailer",
            "Standard Trailer Wait Unpacking/Packing",
            "Sideloader",
        ],
    )
    grossWeight: int = Field(default=0, description="")
    doorType: str = Field(default="any", enum=["any", "rear", "fwd"])
class Job(BaseModel):
    jobType: str = Field(
        ...,
        description="Classify job type based on context, possible values: "
        "IMPORT, EXPORT, MISC, RAIL_INBOUND, RAIL_OUTBOUND",
        enum=["IMPORT", "EXPORT", "MISC", "RAIL_INBOUND", "RAIL_OUTBOUND"],
    )
    cusRefId: Optional[str] = Field(
        default=None, description="customer referal id")
        vessel: Optional[str] = Field(
        default=None, description='Vessel name (e.g., "MV Oceanic")'
    )
    vessel: Optional[str] = Field(
        default=None, description='Vessel name (e.g., "MV Oceanic")'
    )
    voyage: Optional[str] = Field(
        default=None, description='Voyage name (e.g., "VOY123")'
    )
    portOfLoading: Optional[str] = Field(
        default=None, description="loading port location"
    )
    portOfDischarge: Optional[str] = Field(
        default=None, description="discharge port location"
    )
    eta: Optional[datetime] = Field(default=None, description="")
    etd: Optional[datetime] = Field(default=None, description="")
    agentName: Optional[str] = Field(default=None, description="")
    consigneeName: Optional[str] = Field(default=None, description="")
    consignorName: Optional[str] = Field(default=None, description="")
    warehouseName: Optional[str] = Field(default=None, description="")
    accountReceivableName: Optional[str] = Field(default=None, description="")
    # Lồng kiểu Container trong kiểu Job
    jobContainers: List[Container] = Field(
        default=None,
        description="A list container information according to the schema",
    )
```
== Schema linh động
Giống như Prompt, để người dùng có thể thoải mái tùy chỉnh nội dung prompt, tôi
đã hiện thực một thư viện Python cho phép đọc định nghĩa của schema theo cấu
trúc của `ModelDefinition` cơ bản như sau (xem source code của thư viện tại:
github.com/qmi03/pydantic_dynamic_model):
```python
class ModelDefinition(BaseModel):
    model_name: str = Field(..., pattern="^[a-zA-Z_][a-zA-Z0-9_]*$")
    fields: List[FieldDefinition]
```
Lớp `ModelDefinition`
- `model_name` (kiểu: `string`): Định nghĩa tên của schema, và
- `fields` (kiểu: `[FieldDefinition`): Định nghĩa danh sách các miền dữ liệu ở
  thuộc tính `fields`.

Trong đó, lớp `FieldDefinition` được định dạng như sau:
```python
class FieldDefinition(Frozen):
    name: str = Field(..., pattern="^[a-zA-Z_][a-zA-Z0-9_]*$")
    base_type: Union[SimpleType, "ModelDefinition"]
    wrappers: List[WrapperType] = Field(default_factory=list)
    required: bool = True
    default: Optional[Any] = None
    description: Optional[str] = None
    validator_defs: List[FieldValidatorDef] = Field(default_factory=list)
    enum_values: Optional[List[str]] = None
    metadata: Dict[str, Any] = Field(default_factory=dict)

```
bao gồm:
- `name` (kiểu: `string`) Tên của miền dữ liệu.
- `base_type` (kiểu: `SimpleType` hoặc `ModelDefinition`): kiểu dữ liệu gốc, gồm
  các giá trị cơ bản như "string", "integer", "float", "boolean", "datetime", "date",
  và thuộc kiểu `ModelDefinition`, cho phép dữ liệu được lồng. Ví dụ, trong trường
  hợp của chúng ta: kiểu Container được lồng trong kiểu Job.
- `wrapper_type` (kiểu: [`WrapperType`]): Kiểu dữ liệu lồng lấy kiểu dữ liệu gốc
  (base_type). Các kiểu lồng hỗ trợ: là `list`, `dict`, `enum`. Nhập danh sách
  rỗng nếu không có kiểu lồng.

- `required` (kiểu: `bool`): Đánh dấu liệu trường này có bắt buộc không. Mặc định
  là True.

- `default` (kiểu: `Optional[Any]`): Giá trị mặc định của trường nếu có.

- `description` (kiểu: `Optional[str]`): Mô tả ngắn gọn về trường dữ liệu.

- `enum_values` (kiểu: `Optional[List[str]]`): Giá trị liệt kê cho các trường kiểu
  enum.

- `metadata` (kiểu: `Dict[str, Any]`): Metadata liên quan đến trường.

Hàm tạo ra schema linh động:
`def create_dynamic_model(model_definition: ModelDefinition) -> type[BaseModel]`

Ví dụ cách sử dụng hàm trong hệ thống hiện tại:
+ Đọc định nghĩa của schema trong `schema.json` và chuyển về dạng `ModelDefinition`
+ Gọi hàm `create_dynamic_model()`
```python
import json
schema_definition = json.loads("./schema.json")
parsed_schema_definition = ModelDefinition.model_validate(schema_definition)

schema = create_dynamic_model(parsed_schema_definition)
```
```json
// Ví dụ ngắn của schema.json
{
  "model_name": "BaseTransportJobInformation",
  "fields": [
    {
      "name": "jobType",
      "base_type": "string",
      "wrappers": [],
      "required": true,
      "default": null,
      "description": "Classify job type based on context, possible values: IMPORT, EXPORT, MISC, RAIL_INBOUND, RAIL_OUTBOUND",
      "validator_defs": [
        {
          "validator_type": "custom",
          "params": {
            "customFunctionDef": "def validate(cls, v):\n    valid_types = ['IMPORT', 'EXPORT', 'MISC', 'RAIL_INBOUND', 'RAIL_OUTBOUND']\n    if v.upper() not in valid_types:\n        raise ValueError(f'Invalid jobType: {v}')\n    return v.upper()\n    "
          },
          "error_message": "Invalid job type"
        }
      ],
      "enum_values": [
        "IMPORT",
        "EXPORT",
        "MISC",
        "RAIL_INBOUND",
        "RAIL_OUTBOUND"
      ],
      "metadata": {}
    },
    {
      "name": "voyage",
      "base_type": "string",
      "wrappers": ["optional"],
      "required": false,
      "default": null,
      "description": "Voyage name (e.g., \"VOY123\")",
      "validator_defs": [],
      "enum_values": null,
      "metadata": {}
    },
    {
      "name": "accountReceivableName",
      "base_type": "string",
      "wrappers": ["optional"],
      "required": false,
      "default": null,
      "description": "",
      "validator_defs": [],
      "enum_values": null,
      "metadata": {}
    },
    {
      "name": "jobContainers",
      "base_type": {
        "model_name": "Container",
        "fields": [
          {
            "name": "grossWeight",
            "base_type": "float",
            "wrappers": [],
            "required": true,
            "default": null,
            "description": "",
            "validator_defs": [],
            "enum_values": null,
            "metadata": {}
          },
        ]
      },
      "wrappers": ["optional", "list"],
      "required": false,
      "default": null,
      "description": "A list container information according to the schema",
      "validator_defs": [],
      "enum_values": null,
      "metadata": {}
    }
  ]
}
```
