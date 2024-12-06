= Công nghệ sử dụng
== RAG
Về cơ bản, để hiện thực được một kiến trúc học tăng cường, thì ta chỉ cần các
bước sau (có thể lồng ghép các bước sau nhiều lần):
- Chuẩn bị lời gọi: soạn prompt, chuẩn hóa dữ liệu, đóng gói thành lời gọi
  (request) qua API của nhà cung cấp mô hình ngôn ngữ lớn (ví dụ: OpenAI, các dịch
  vụ như Groq, Huggingface,...).
- Xử lý kết quả trả về của API.

Tuy nhiên, vì mỗi nhà cung cấp có một cấu trúc riêng về API, giả sử số nhà cung
cấp là n. Ta phải thực hiện quy trình trên với độ phức tạp O(n). Ta có thể sử
dụng thư viện (thư viện) Langchain để giúp đưa bài toán này về O(1).

+ Langchain và Python\ (tác giả sử dụng Python phiên bản 3.12 và Langchain phiên
  bản 0.3)
  a. Giới thiệu về Langchain:\ Langchain là một framework giúp nhà phát triển có thể
    nhanh chóng tạo ra mô hình học tăng cường một cách nhanh chóng bằng cách chuẩn
    hóa quy trình tạo kiến trúc học tăng cường.\ Bên cạnh đó, Langchain đóng gói và
    trừu tượng hóa bước gọi API đến phần lớn các nhà cung cấp lớn trên thị trường.
    Vì thế, người dùng chỉ cần xây dựng kiến trúc và yêu cầu Langchain gọi dịch vụ.
    Nhờ đó mà nhà phát triển kiến trúc học tăng cường có thể thử nghiệm trên nhiều
  loại mô hình ngôn ngữ lớn khác nhau.
  + Python\ Langchain được viết dựa trên Python nên ta sẽ sử dụng ngôn ngữ Python
  cho dự án này.

=== Lựa chọn mô hình ngôn ngữ lớn:
