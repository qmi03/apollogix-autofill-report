= Phân tích chi tiết đề tài
Đề tài có thể được chia ra làm hai bước chính:
#enum(enum.item(1)[Biến dữ liệu chưa có cấu trúc về dữ liệu có cấu trúc])
Phát triển một hàm có khả năng biến dữ liệu từ định dạng dữ liệu không cấu trúc
(chuỗi/hình ảnh/pdf) sang dạng json (dữ liệu có cấu trúc).

#enum(enum.item(2)[Dịch vụ API])
Phát triển dịch vụ (API service) để nhận đầu vào dữ liệu không cấu trúc từ nơi
gọi (hệ thống TMS) và trả về dữ liệu có cấu trúc.

Đối với mảng kiến thức đầu tiên, ta có thể biến yêu cầu đề bài thành hai hướng
giải quyết bài toán khác nhau:
- Named Entity Recognition (NER) - tạm dịch Nhận dạng Thực thể để xác định các
  token trên dữ liệu đầu vào thuộc miền dữ liệu nào trong dạng json mà công ty yêu
  cầu.
- Text Extraction - tạm dịch: trích xuất văn bản. Bằng cách viết prompt thông minh
  cho mô hình ngôn ngữ, ta có thể truyền vào định nghĩa các miền giá trị cần trích
  xuất trong văn bản cho mô hình có khả năng hiểu ngôn ngữ loài người và trả về
  kết quả dữ liệu có cấu trúc như mong đợi.
