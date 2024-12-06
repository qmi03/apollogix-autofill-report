= Nhận dạng thực thể (NER):

Để hiện thực hóa giải pháp NER, cần thực hiện các bước sau:
#set enum(numbering: "1.a.")
+ Thu thập dữ liệu: Thu thập tập dữ liệu có chứa các văn bản đã được gắn nhãn thực
  thể. Việc gắn nhãn có thể thực hiện thủ công hoặc bằng các công cụ tự động hóa.
  Đảm bảo dữ liệu đa dạng và đại diện tốt cho bài toán.
+ Tiền xử lý dữ liệu: Làm sạch dữ liệu, loại bỏ các ký tự không cần thiết. Chuẩn
  hóa văn bản (ví dụ: chuyển chữ hoa thành chữ thường, xóa khoảng trắng thừa).
  Tách văn bản thành câu hoặc token (từ hoặc cụm từ).
+ Trích xuất đặc trưng: Sử dụng các kỹ thuật như gán nhãn từ loại (POS tagging),
  tạo vector từ biểu diễn (word embeddings), và khai thác ngữ cảnh xung quanh từ.
  Chọn các đặc trưng phù hợp với mô hình NER cụ thể.
+ Huấn luyện mô hình: Sử dụng mô hình học máy (như CRF, SVM) hoặc học sâu (như
  BiLSTM-CRF, Transformer-based models như BERT) để huấn luyện trên tập dữ liệu
  gắn nhãn. Điều chỉnh các siêu tham số (hyperparameters) để tối ưu hóa hiệu suất.
+ Đánh giá mô hình: Đánh giá chất lượng mô hình qua các chỉ số như Precision,
  Recall, và F1 Score. Phân tích các trường hợp mô hình nhận dạng sai để cải
  thiện.
+ Tinh chỉnh mô hình: Tăng cường dữ liệu huấn luyện hoặc sử dụng kỹ thuật như tăng
  cường dữ liệu (data augmentation). Áp dụng các phương pháp như học chuyển giao
  (transfer learning) để cải thiện độ chính xác.
+ Suy luận (Inference): Triển khai mô hình để xử lý các văn bản mới, gắn nhãn các
  thực thể trong văn bản.
+ Hậu xử lý: Liên kết thực thể với cơ sở tri thức hoặc các nguồn dữ liệu khác để
  làm phong phú thêm thông tin. Loại bỏ các thực thể không phù hợp hoặc hợp nhất
  các thực thể trùng lặp.

Ưu điểm:

- Khả năng tự động hóa cao, tiết kiệm thời gian so với các phương pháp thủ công.
- Có thể xử lý dữ liệu văn bản khổng lồ một cách hiệu quả.
- Kết hợp được nhiều loại đặc trưng để cải thiện độ chính xác.

Nhược điểm:

- Yêu cầu tập dữ liệu được gắn nhãn chất lượng cao, chi phí gắn nhãn lớn.
- Hiệu quả của mô hình phụ thuộc mạnh vào chất lượng dữ liệu và đặc trưng.
- Mô hình có thể gặp khó khăn khi xử lý ngôn ngữ không chính thức hoặc lỗi chính
  tả (tốn kém việc tiền xử lý sửa lỗi chính tả).

Tham khảo: https://www.ibm.com/topics/named-entity-recognition

Ta có thể loại thẳng tay hướng tiếp cận này vì:
- Bộ dữ liệu cung cấp cho công việc huấn luyện quá ít ỏi (khoảng 40 mẫu).
- Việc dán nhãn phải làm thủ công, đòi hỏi người có chuyên môn hoặc quen với việc
  nhập mẫu (ví dụ: người bên nhánh vận hành của công ty). Nghĩa là chi phí dãn
  nhãn (thời gian, nhân lực) là quá lớn đối với 1 thực tập sinh trong 1 kỳ thực
  tập.
Vì vậy phương pháp này là không khả thi.
