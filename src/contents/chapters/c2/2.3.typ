= Hướng tiếp cận
== Biến dữ liệu chưa có cấu trúc về dữ liệu có cấu trúc
Đề xuẫt ba phương pháp có thể sử dụng:
1. NER: Đưa bài toán về bài toán Nhận dạng Thực thể (Named Entity Recognition) và
  sử dụng mô hình học máy kinh điển để xử lý bài toán
2. RAG: sử dụng mô hình học sâu deep learning như ChatGPT để trích xuất thông tin.
  Trong đó có yêu cầu mô hình ngôn ngữ trả về dạng chuỗi (string) theo format của
  của 1 dạng dữ liệu có cấu trúc như json.

  2.1 Sử dụng mô hình ngôn ngữ giao tiếp (chat model)

  2.2 Sử dụng mô hình đa thể thức (multi modal model)

#set heading(offset: 3)
#{ include "./2.3/2.3.1.typ" }
#{ include "./2.3/2.3.2.typ" }
