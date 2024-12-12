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
  bản 0.3) a. Giới thiệu về Langchain:\ Langchain là một framework giúp nhà phát
  triển có thể nhanh chóng tạo ra mô hình học tăng cường một cách nhanh chóng bằng
  cách chuẩn hóa quy trình tạo kiến trúc học tăng cường.\ Bên cạnh đó, Langchain
  đóng gói và trừu tượng hóa bước gọi API đến phần lớn các nhà cung cấp lớn trên
  thị trường. Vì thế, người dùng chỉ cần xây dựng kiến trúc và yêu cầu Langchain
  gọi dịch vụ. Nhờ đó mà nhà phát triển kiến trúc học tăng cường có thể thử nghiệm
  trên nhiều loại mô hình ngôn ngữ lớn khác nhau.
  + Python\ Langchain được viết dựa trên Python nên ta sẽ sử dụng ngôn ngữ Python
  cho dự án này.

== Mô hình ngôn ngữ lớn (LLM)
Vì Langchain cho phép dễ dàng thay đổi linh hoạt nhiều mô hình ngôn ngữ mà không
cần phải xây dựng lại kiến trúc học tăng cường, tôi lựa chọn các mô hình ngôn
ngữ được cung cấp bởi Meta (Llama 3.2 và các phiên bản tương tự), Google
(Gemini, Vertex,...) vì họ cung cấp API miễn phí đối với cá nhân nhà phát triển.
Đồng thời tôi cũng sẽ sử dụng các model được huấn luyện thêm (finetune) cho tác
vụ gọi hàm (function calling) trên nền tảng Huggingface. Sau khi xây dựng kiến
trúc học tăng cường hoạt động tốt thì sẽ cân nhắc chuyển sang dùng các model của
OpenAI (GPT-4o,...) hay Anthropic (Claude Sonnet 3.5,...).

== Thư viện Fastapi:
Để hiện thực nhanh chóng microservice này, ta có thể sử dụng thư viện FastAPI
của Python, thư viện này cho phép nhà phát triển nhanh chóng viết ra dịch vụ bởi
hướng tiếp cận đơn giản và hướng dẫn sử dụng kĩ, cùng với đó là hệ sinh thái tốt
và hỗ trợ lập trình async qua uvicorn server async (ASGI server) hoặc
multi-processing (uvicorn workers).
