CHƯƠNG 1: GIỚI THIỆU
1.1.	Giới thiệu sơ lược đề tài 
•	Đề tài: University DB (University Database) là đề tài trình bày một mô hình thiết kế để xây dựng kho dữ liệu cho một trường đại học điển hình hệ thống thông tin.
	Về bản chất, tất cả các hệ thống này được kết nối với nhiều cơ sở dữ liệu phân tán cơ bản được sử dụng cho các giao dịch và quy trình hàng ngày.
•	Đề tài này đề xuất một thiết kế kho dữ liệu cho một hệ thống thông tin đại học điển hình có vai trò là giúp đỡ và hỗ trợ. 
	Thiết kế đề xuất biến đổi cơ sở dữ liệu hoạt động hiện tại thành cơ sở dữ liệu thông tin hoặc kho dữ liệu bằng cách làm sạch dữ liệu vận hành hiện có.
1.2.	Lý do chọn đề tài
•	Một trường đại học điển hình thường bao gồm rất nhiều hệ thống con quan trọng cho các quy trình và hoạt động nội bộ của nó.
	Ví dụ về các hệ thống con này bao gồm hệ thống đăng ký sinh viên, hệ thống bảng lương, hệ thống kế toán, hệ thống quản lý khóa học, hệ thống nhân viên và nhiều hệ thống khác.
	Tuy nhiên, các trường đại học hiếm khi sử dụng các hệ thống để xử lý phân tích dữ liệu, dự báo, dự đoán và ra quyết định.
•	Nếu các trường đại học có thể khai thác các dữ liệu có sẵn đó thì việc đưa ra các quyết định, dự báo sẽ chính xác và nhanh chóng hơn rất nhiều.
	Không chỉ thế việc quản lý các khóa học, hệ thống nhân viên, sinh viên cũng như tiền lương và tiền học phí sẽ được minh bạch, tiết kiệm, tránh tốn kém, hiệu quả hoạt động tốt hơn.
CHƯƠNG 2: PHÁC THẢO KẾ HOẠCH
2.1.	Công việc dự định
•	Thống nhất dữ liệu cần sử dụng
•	Tạo enterprice bus matrix, fact và dimension
•	Tích hợp dữ liệu từ dataset vào data warehouse
•	Thiết kế các truy vấn trên data warehouse/ data mart để tạo báo cáo
2.2.	Phác thảo kế hoạch
•	Thống nhất sử dụng dữ liệu – University DB:Cả nhóm
•	Tạo các data mart từ CSDL University DB:Phạm Văn Quỹ - Nguyễn Thị Ngọc
•	Thiết kết data warehouse/data mart - Tạo Enterprice bus matrix và bảng Detailed bus Matrix:Phạm Văn Quỹ                
•	Thiết kết data warehouse/data mart - Thiết kế chi tiết cho các Dimension và tạo Dimension hoặc Fact:Nguyễn Thị Ngọc
•	Tích hợp dữ liệu từ dataset đã chọn vào data warehouse - Tạo các stage table:Trần Gia Bảo
•	Tích hợp dữ liệu từ dataset đã chọn vào data warehouse - Load dữ liệu từ các stage table qua data mart:Uông Thị Thanh Thủy
•	Thiết kế các truy vấn trên data warehouse đã xây dựng để tạo báo cáo:Vũ Đặng Quỳnh Giang
•	Thiết kế các truy vấn trên data mart đã xây dựng để tạo báo cáo:Nguyễn Ngọc Dương

TÀI LIỆU THAM KHẢO
•	Database System Concepts Seventh Edition/ Avi Silberschatz - Henry F. Korth - S. Sudarshan
•	https://www.db-book.com/db7/university-lab-dir/sample_tables-dir/index.html
