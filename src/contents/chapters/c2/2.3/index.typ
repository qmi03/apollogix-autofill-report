= Phân tích các hướng tiếp cận
== Biến dữ liệu chưa có cấu trúc về dữ liệu có cấu trúc
Đề xuẫt hai phương pháp có thể sử dụng:
+ Huấn luyện mô hình:
  + Xây dựng mô hình: Đưa bài toán về bài toán Nhận dạng Thực thể *NER* (Named
    Entity Recognition) và sử dụng mô hình học máy kinh điển để xử lý bài toán
  + Fine-tuning (transfer learning): Huấn luyện mô hình ngôn ngữ để mô hình luôn
    sinh ra được câu trả lời có cấu trúc từ đầu vào
+ Sử dụng mô hình đã có sẵn (*RAG*): Sử dụng mô hình ngôn ngữ học sâu (deep
  learning model) như GPT-4o để trích xuất thông tin. Trong đó, người dùng yêu cầu
  mô hình ngôn ngữ trả về dạng chuỗi (string) theo format của của 1 dạng dữ liệu
  có cấu trúc như json.
  + Sử dụng mô hình ngôn ngữ giao tiếp (chat model): chuyển dạng pdf/hình ảnh/... về
    dạng chuỗi bằng công nghệ OCR.
  + Sử dụng mô hình đa thể thức (multi modal model): truyền thẳng dạng pdf/hình
    ảnh/... mà không cần có bước OCR.

#set heading(offset: 3)
#{ include "./2.3.1a.typ" }
#{ include "./2.3.1b.typ" }
