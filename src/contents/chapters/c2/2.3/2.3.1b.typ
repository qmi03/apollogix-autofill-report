= Học tăng cường (RAG)
Vì những nhược điểm nêu ra ở hướng tiếp cận trên. Tôi đã lựa chọn phương pháp
học tăng cường.

*Học tăng cường là gì?*

Là phương pháp dựa trên mô hình đã được huấn luyện sẵn (các mô hình ngôn ngữ lớn
như GPT-4o, Llama3, Mistral,...).

Phần lớn các mô hình ngôn ngữ lớn chỉ có chức năng nhận vào một đầu vào là một
chuỗi nhập của người dùng và trả về một chuỗi kết quả. Năng lực của mô hình ngôn
ngữ lớn như vậy là còn quá hạn hẹp.

Một ví dụ cho học tăng cường là ChatGPT hay nhiều chat bot khác, đầu vào và kết
quả của lần gọi trước sẽ được nối với đầu vào mới và tạo thành 1 chuỗi, ta sẽ
tạo được một mô hình có khả năng trò chuyện với người dùng.
#figure(
  table(
    columns: (auto, auto, auto, auto), inset: 10pt, align: horizon, table.header([], [*Người dùng nhập*], [*Đầu vào*], [*Kết quả*]), [1], [Xin chào], [Human: Xin chào], [Xin chào, tôi có thể giúp gì được cho bạn?], [2], [Tôi muốn đặt câu hỏi về học tăng cường.], [Human: Xin chào \
      AI: Xin chào, tôi có thể giúp gì được cho bạn? \
      Human: Tôi muốn đặt câu hỏi về học tăng cường. \
    ], [Học tăng cường là phương pháp dựa trên mô hình đã được huấn luyện sẵn... ],
  ), caption: [Minh họa về cách chatbot hoạt động dựa trên mô hình ngôn ngữ],
)

*Chức năng gọi hàm/công cụ (function/tool calling) của mô hình ngôn ngữ lớn*

Mô hình ngôn ngữ ở dạng thuần túy nhất không có khả năng lấy được thông tin ở
thời gian thực. Vì vậy ta không thể nào đặt câu hỏi mong chờ kết quả của thời
gian thực. Các nhà cung cấp mô hình hiện nay đã cung cấp thêm cho mô hình khả
năng gọi hàm. Gọi hàm gồm các bước trừu tượng như sau:
+ Trích đầu vào cho một hàm
+ Gọi hàm
+ Sinh ra câu trả lời cho người dùng dựa trên đầu ra của hàm
(Theo dõi hình minh họa ở dưới)
#figure(
  image("/static/c2/function_call.png"), caption: [Minh họa về cách gọi hàm của mô hình ngôn ngữ lớn],
)

*Vì sao chọn phương pháp này phù hợp hơn để giải quyết bài toán thay cho phương
pháp huấn luyện mô hình*

Nhược điểm:
- Độ chính xác hội tụ sớm sau một thời gian ngắn sử dụng: Vì chúng ta sẽ không
  huấn luyện mô hình, nên cũng không thể tăng độ chính xác theo thời gian khi kích
  thước bộ dữ liệu tăng lên.
Ưu điểm:
- Không cần nghĩ đến việc huấn luyện: RAG sử dụng các mô hình ngôn ngữ lớn (LLMs)
  đã được huấn luyện trên kho dữ liệu khổng lồ, không yêu cầu một tập dữ liệu gắn
  nhãn cụ thể.
- Linh hoạt yêu cầu bài toán: Vì các LLM được huấn luyện dựa trên nhiều ngữ cảnh
  khác nhau nên có thể thích ứng được với nhiều loại yêu cầu.
- Dễ hiện thực: Không cần phải xây dựng chuỗi huấn luyện.
- Có thể dễ dàng khắc phục nhược điểm: Không thể tăng độ chính xác theo thời gian
  có thể được bỏ qua nhờ các kĩ thuật:
  - Việc viết lời gợi (prompting) hay hơn
  - Viết lời gợi kèm theo ví dụ (khoảng 2-5 ví dụ): Few-shot Prompting
