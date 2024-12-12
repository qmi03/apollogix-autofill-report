= Viết dịch vụ Backend xử lý dữ liệu
== Các API endpoints
=== /api/ai/invoke (POST)
API này cho phép _bất cứ người dùng nào_ truy cập và gọi dịch vụ AI.
#enum(enum.item(1)[Mô tả])
Hệ thống sẽ có 1 endpoint API chính cho người dùng là `/api/ai/invoke`, cụ thể
như sau:
- Tham số:
  - file: File pdf đầu vào.
  - template_name (Optional[str]): Tên các mẫu ví dụ để model trả lời thông minh
    hơn. Nếu có template, mô hình sẽ chọn ngẫu nhiên 3 mẫu theo template để chèn ví
    dụ vào lời gọi.
- Trả về: Dạng json đã qua xử lý

#enum(enum.item(2)[Sequence Diagram])
#figure(
  image("/static/images/sequence_diagram.png", height: 60%), caption: [Sequence diagram của endpoint `/api/ai/invoke`],
)

=== Tập hợp các endpoints thuộc /api/chain/
API endpoint này cho phép _người có quyền admin_ truy cập và thao tác lên dữ
liệu của về prompt, schema, example (xem kĩ hơn ở trang documentation Swagger
khi chạy API)

Mô tả cơ bản như sau:

#enum(enum.item(1)[Prompt])
- Xem system message và tips mà kiến trúc RAG đang sử dụng hiện tại.
- Thay đổi prompt của kiến trúc (xem phần Prompt):
  - Thêm tips
  - Thay đổi system message
#enum(enum.item(2)[Schema])
- Xem schema hiện tại
- Thay đổi schema hiện tại
