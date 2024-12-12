= (Mở rộng) Truyền thêm ví dụ vào model
Để mô hình có thể hoạt động tốt trên lượng dữ liệu chưa từng gặp phải. Ta sẽ sử
dụng phương pháp Few-Shot Prompting (tạm dịch: Vài nhát ví dụ). Theo bài này của
Langchain, cho thấy:

- Đối với model một số model, chỉ cần cho thêm 3 ví dụ giúp model tăng độ chính
  xác lên 6 lần.
  #figure(
    image("/static/images/fewshot_Math.png"), caption: [So sánh hiệu năng của kết quả trả về khi gọi ví dụ. \ Tham khảo từ:

      https://blog.langchain.dev/few-shot-prompting-to-improve-tool-calling-performance/],
  )

*Áp dụng vào RAG*

Vì cấu trúc các mẫu pdf không thống nhất, và thay đổi tùy theo doanh nghiệp/đất
nước, ta có thể cho người dùng xác định tên doanh nghiệp, từ đó model sẽ lựa
chọn ngẫu nhiên trong tập dữ liệu mẫu và cho vào ví dụ giúp model trả lời thông
minh hơn.
