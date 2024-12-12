= Viết dịch vụ Backend xử lý dữ liệu
== Các API endpoints
=== /api/ai/invoke
#enum(enum.item(1)[Mô tả])
Hệ thống sẽ có 1 endpoint API chính cho người dùng là `/api/ai/invoke`, cụ thể
như sau:
- Tham số:
  - file: File pdf đầu vào.
  - template_name (Optional[str]): Tên các mẫu ví dụ để model trả lời thông minh
    hơn.
- Trả về: Dạng json đã qua xử lý

#enum(enum.item(2)[Sequence Diagram])
#figure(
  image("/static/images/sequence_diagram.png"), caption: [Sequence diagram của endpoint `/api/ai/invoke`],
)
