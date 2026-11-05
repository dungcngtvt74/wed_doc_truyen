-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3307
-- Thời gian đã tạo: Th10 12, 2026 lúc 11:23 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `doc_truyen_web`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `binhluan`
--

CREATE TABLE `binhluan` (
  `id` int(11) NOT NULL,
  `id_nguoidung` int(11) NOT NULL,
  `id_chuong` int(11) NOT NULL,
  `noi_dung` text NOT NULL,
  `ngay_tao` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chuong`
--

CREATE TABLE `chuong` (
  `id` int(11) NOT NULL,
  `id_truyen` int(11) NOT NULL,
  `so_chuong` int(11) NOT NULL,
  `tieu_de` varchar(255) DEFAULT NULL,
  `ngay_dang` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chuong`
--

INSERT INTO `chuong` (`id`, `id_truyen`, `so_chuong`, `tieu_de`, `ngay_dang`) VALUES
(1, 8, 1, 'Chú khủng long của Nobita', '2026-01-11 14:38:22'),
(2, 9, 1, 'Muốn lấy mật đừng phá tổ ong', '2026-01-13 09:49:41'),
(3, 9, 2, 'Bí Mật Lớn Nhất Trong Phép Ứng Xử', '2026-01-13 10:12:43'),
(4, 9, 3, 'Ai Làm Được Điều Dưới Đây, Người Đó Sẽ Có Cả Thế Giới', '2026-01-13 10:14:04'),
(12, 8, 2, 'no ', '2026-09-21 00:45:33'),
(13, 3, 1, 'Chap 1', '2026-10-04 20:51:51'),
(14, 3, 2, 'Chap 2', '2026-10-04 20:53:56'),
(15, 3, 3, 'Chap 3', '2026-10-04 20:57:43');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoso_nguoidung`
--

CREATE TABLE `hoso_nguoidung` (
  `id_nguoidung` int(11) NOT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(255) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `ngay_tao` datetime DEFAULT current_timestamp(),
  `ngay_cap_nhat` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `hoso_nguoidung`
--

INSERT INTO `hoso_nguoidung` (`id_nguoidung`, `ho_ten`, `ngay_sinh`, `gioi_tinh`, `so_dien_thoai`, `dia_chi`, `avatar`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 'admin', '2005-02-05', 'nam', '0359330545', 'TB', '1789927473178.jpg', '2026-09-03 01:25:00', '2026-09-21 01:04:33'),
(3, 'Phạm Hoàng Trung Hiếu', '2005-06-06', 'nam', '0967662005', 'Hà Nam', '6965b61931db8_1768273433.jpg', '2026-01-13 10:03:53', '2026-01-13 10:04:00'),
(8, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-09 10:07:26', '2026-08-09 10:07:26'),
(12, 'dungvn', '2015-03-11', 'nam', '0126747655', 'yb', '1790822755969.webp', '2026-09-03 03:50:09', '2026-10-01 09:45:56');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `layout`
--

CREATE TABLE `layout` (
  `id` int(11) NOT NULL,
  `ten_theloai` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `luu_trang_doc`
--

CREATE TABLE `luu_trang_doc` (
  `id_nguoidung` int(11) NOT NULL,
  `id_truyen` int(11) NOT NULL,
  `id_chuong` int(11) NOT NULL,
  `so_trang` int(11) NOT NULL,
  `ngay_cap_nhat` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `luu_trang_doc`
--

INSERT INTO `luu_trang_doc` (`id_nguoidung`, `id_truyen`, `id_chuong`, `so_trang`, `ngay_cap_nhat`) VALUES
(1, 3, 14, 1, '2026-10-12 09:19:38'),
(1, 8, 1, 1, '2026-10-12 09:19:58'),
(1, 9, 2, 1, '2026-10-12 09:19:50'),
(3, 8, 1, 2, '2026-01-13 09:40:44'),
(3, 9, 2, 1, '2026-01-13 10:09:41'),
(12, 3, 14, 2, '2026-10-04 14:00:44'),
(12, 8, 1, 1, '2026-10-04 14:01:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoidung`
--

CREATE TABLE `nguoidung` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(255) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `vai_tro` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoidung`
--

INSERT INTO `nguoidung` (`id`, `ten_dang_nhap`, `mat_khau`, `email`, `vai_tro`) VALUES
(1, 'admin', '$2y$10$4Eig779r/aftQbu02ltawuhd2/br6/l8cg255dHGX55pTFXbxCyZi', 'admin@gmail.com', 'admin'),
(3, 'trunghieu', '$2y$10$lBYsTX8hcD8vby2lGOQopOmFk5PCHrDGWhTy/0WG1P/iiDBAQ.CLu', 'trunghieu@gmail.com', 'user'),
(6, 'binh', '$2y$10$jprhhrxbpra2YSjUrbq3LuIO3U/VMfp6yWJAqOLdWCFJH3LGlm7bW', 'binh@gmail.com', 'user'),
(7, 'anhduc', '$2y$10$IDKhqZJW8ppjOTkj/sQcp.wJe9nEQhaXl4n035BryYMchZIZaxV.i', 'anhduc@gmail.com', 'user'),
(8, 'dung', '123456', 'vutiendung05022005@gmail.com', 'user'),
(9, 'dung2', '123456', 'vdung7116@gmail.com', 'user'),
(10, 'dung3', '123456', 'vudung05022005@gmail.com', 'user'),
(11, 'dung4', '$2a$10$HdN/82TMmH345tOwxSiF8Ool.7hLX9Z/74NA1c1SSu4ZkxTKwIwQa', 'vutiendung05022005lan3@gmail.com', 'user'),
(12, 'dungvn', '$2a$10$puxGaURtEHj5yKmR3.APa.uqY3TVjlDGcbPJVyv7sSvnBshR0nph2', 'vud575618@gmail.com', 'user'),
(13, 'dungvn1', '$2a$10$GTp43n.iZV51Pmr6Vr6oK.SYowI84bfpnuW5Km..eBEBPZaUr7YzW', 'vud575618dr@gmail.com', 'user');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tacgia`
--

CREATE TABLE `tacgia` (
  `id` int(11) NOT NULL,
  `ten_tacgia` varchar(255) NOT NULL,
  `but_danh` varchar(255) DEFAULT NULL,
  `gioi_thieu` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tacgia`
--

INSERT INTO `tacgia` (`id`, `ten_tacgia`, `but_danh`, `gioi_thieu`) VALUES
(1, 'Oda Eiichirō', '', 'Oda Eiichirō sinh ngày 1 tháng 1 năm 1975) là một mangaka người Nhật, tác giả của One Piece - bộ manga bán chạy nhất lịch sử và bộ truyện tranh in từng tập bán chạy nhất'),
(6, 'Hiroshi Fujimoto', '', 'Người có ý tưởng ban đầu về mèo máy Doraemon, ông tập trung vào bộ truyện này đến khi qua đời vào năm 1996'),
(7, 'Masashi Kishimoto', '', 'Kishimoto Masashi sinh ngày 8 tháng 11 năm 1974 ở Okayama) là một họa sĩ truyện tranh đã được biết đến qua bộ truyện tranh nổi tiếng thế giới Naruto và Boruto'),
(8, 'Gotōge Koyoharu', '', 'Gotōge Koyoharu sinh ngày 5 tháng 5 năm 1989) là một mangaka người Nhật Bản, nổi tiếng với loạt manga Thanh gươm diệt quỷ (2016–2020)'),
(9, 'Akira Toriyama', '', 'Akira Toriyama (5 tháng 4 năm 1955 – 1 tháng 3 năm 2024) là một họa sĩ truyện tranh và nhà thiết kế nhân vật người Nhật Bản. Ông được coi là một trong những tác giả vĩ đại và có ảnh hưởng nhất trong lịch sử truyện tranh và đã tạo ra nhiều bộ truyện nổi tiếng và được yêu thích, nổi tiếng nhất là Dragon Ball .'),
(10, 'Dale Carnegie', '', 'Dale Breckenridge Carnegie (trước kia là Carnagey cho tới năm 1922 và có thể một thời gian muộn hơn) (24 tháng 11 năm 1888 – 1 tháng 11 năm 1955) là một nhà văn và nhà thuyết trình Mỹ và là người phát triển các lớp tự giáo dục, nghệ thuật bán hàng, huấn luyện đoàn thể, nói trước công chúng và các kỹ năng giao tiếp giữa mọi người. Ra đời trong cảnh nghèo đói tại một trang trại ở Missouri, ông là tác giả cuốn Đắc Nhân Tâm, được xuất bản lần đầu năm 1936, một cuốn sách hàng bán chạy nhất và được biết đến nhiều nhất cho đến tận ngày nay, nội dung nói về cách ứng xử, cư xử trong cuộc sống. Ông cũng viết một cuốn tiểu sử Abraham Lincoln, với tựa đề Lincoln con người chưa biết, và nhiều cuốn sách khác.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `theloai`
--

CREATE TABLE `theloai` (
  `id` int(11) NOT NULL,
  `ten_theloai` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `theloai`
--

INSERT INTO `theloai` (`id`, `ten_theloai`) VALUES
(1, 'Anime'),
(6, 'Cổ trang'),
(11, 'Hài hước'),
(7, 'Kiếm hiệp'),
(5, 'Kinh dị'),
(14, 'Kỹ năng sống'),
(9, 'Phiêu lưu'),
(13, 'Tâm lý'),
(10, 'Thiếu nhi'),
(2, 'Truyện dài'),
(3, 'Truyện ngắn'),
(4, 'Truyện ngôn tình'),
(8, 'Tu tiên');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `theo_doi_truyen`
--

CREATE TABLE `theo_doi_truyen` (
  `id` int(11) NOT NULL,
  `id_nguoidung` int(11) NOT NULL,
  `id_truyen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trang`
--

CREATE TABLE `trang` (
  `id` int(11) NOT NULL,
  `id_chuong` int(11) NOT NULL,
  `so_trang` int(11) NOT NULL,
  `noi_dung` longtext DEFAULT NULL,
  `anh` varchar(255) DEFAULT NULL,
  `loai` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `trang`
--

INSERT INTO `trang` (`id`, `id_chuong`, `so_trang`, `noi_dung`, `anh`, `loai`) VALUES
(1, 1, 1, '', 'uploads/trang/696353fc667c7.png', 'image'),
(2, 1, 2, '', 'uploads/trang/6963540a8cc2f.png', 'image'),
(3, 1, 3, '', 'uploads/trang/6963542d56b4c.png', 'image'),
(4, 1, 4, '', 'uploads/trang/696354579ab34.png', 'image'),
(5, 1, 5, '', 'uploads/trang/6963547b82437.png', 'image'),
(6, 1, 6, '', 'uploads/trang/696354ad2bd35.png', 'image'),
(7, 1, 7, '', 'uploads/trang/696354c8ac956.png', 'image'),
(8, 1, 8, '', 'uploads/trang/696354e46ab21.png', 'image'),
(9, 1, 9, '', 'uploads/trang/6963551563be9.png', 'image'),
(10, 1, 10, '', 'uploads/trang/6963552f4e57e.png', 'image'),
(12, 2, 1, 'Ngày 7 tháng 5 năm 1931.\r\n\r\nTiếng huyên náo và tiếng chân chạy rầm rập trên đường phố New York. Cảnh sát đang rượt đuổi một tên tội phạm nguy hiểm. Cuối cùng, sau rất nhiều nỗ lực và quyết tâm, cảnh sát đã tốm được Crowley “Hai Súng”, một tên giết người hàng loạt, ngay tại nơi mà hắn không ngờ đến : nhà người yêu cầu hắn trên đại lộ West End.\r\n\r\nMột trăm năm mươi cảnh sát và mật vụ bao vây toà nhà cao nhất, nơi hắn ẩn náu. Họ chọc thủng mái nhà, phun khói và bố trí cả súng máy tại các cửa sổ của những cao ốc xung quanh. Âm thanh chát chúa của những tràng súng máy và súng ngắn vang lên liên tục trong hơn một giờ đồng hồ. Bên trong căn phòng ở tầng cao nhất ấy, Crowley ẩn người sau những chiếc ghế bành độn bông dày, quyết liệt chống trả lực lượng cảnh sát bằng những tràng súng liên thanh. Nhưng cuối cùng, tên tội phạm có tài thiện xạ này cũng phải đầu hàng.\r\n\r\nCảnh sát trưởng New York, ông E. P. Mulrooney nhấn mạnh rằng tên Crowley “Hai Súng” là một trong những tên tội phạm nguy hiểm và tàn ác nhất trong lịch sử tội phạm ở thành phố đông dân nhất nước Mỹ này. Một điểm rất đáng lưu ý về con người Crowley là: “Chỉ một lý do cỏn con, thặm chí không cần có lý do nào, hoặc đơn giản để giải sầu, hắn cũng có thể chĩa súng vào người khác và bóp cò“. Tuy nhiên, đó là suy nghĩ của cảnh sát. Riêng tên tội phạm máu lạnh này lại không nghĩ như thế. Khi bên ngoài cảnh sát tìm mọi cách để bắt hắn thì trong phòng, Crowley đang viết một bức thư. Bức thư còn dính vết máu đỏ. Và, đây là những gì Crowley đã viết: “Dưới lớp áo này là một trái tim mệt mỏi nhưng dịu dàng – một trái tim không hề làm tổn thương ai”. Đọc những dòng này, ai chẳng thấy lòng mình xúc động nhưng sự thật thì lại trái ngược với những gì hắn viết. Chỉ vài giờ trước đó, Crowley đã nỗ súng vào một cảnh sát giao thông khi anh ta chặn xe hắn để kiểm tra bằng lái. Khi viên cảnh sát ngã gục xuống, Crowley đã nhảy ra khỏi xe, chộp khẩu súng ngắn của nạn nhân và lạnh lùng bồi thêm một phát nữa vào thân hình đang run rẩy hấp hối. Crowley bị kết án tử hình. Trên ghế điện ở nhà tù Sing Sing, hắn còn nguỵ biện rằng: “Phải chăng đây là sự trừng phạt mà tôi phải chịu vì đã giết người? Không! Đây là sựï trừng phạt mà tôi phải chịu chỉ vì tôi cần tự bảo vệ mình”.\r\n\r\nThật kỳ lạ là một kẻ thủ ác rõ ràng như vậy lại không chịu nhìn nhận tội lỗi của mình.\r\n\r\nTôi có trao đỗi thư từ qua lại với Lewis Lawer, viên cai ngục nhà tù Sing Sing (là nơi giam giữ những tên tội phạm nguy hiểm nhất ở New York). Lewis Lawer tâm sự: “Rất hiếm phạm nhân ở Sing Sing tự xem mình là người xấu. Họ nghĩ họ cũng là những con người bình thường như anh và tôi. Họ có thể kể cho anh nghe tại sao họ phá một két sắt hay nhanh tay bấm cò súng. Hầu hết bọn họ đều tìm cach đưa ra những lý lẽ dối trá để bào chữa cho những hành vi phạm pháp và vô lương tâm của mình. Họ kiên quyết cho rằng không có lý do gì để bỏ tù họ cả”.\r\n\r\nNếu như Al Capone(3), “Hai Súng” và những tay anh chị thuộc các băng đảng xã hội đen không bao giờ thừa nhận tội ác tày trời của mình thì liệu những con người bình thường có dễ dàng tự nhìn nhận những sai lầm hết sức đời thường của mình không?\r\n\r\nJohn Wanamaker, người sáng lập chuỗi cữa hàng bán lẻ mang tên ông, từng thừa nhận rằng: “Cách đây ba mươi năm, tôi hiểu rằng mắng nhiếc người khác là ngu ngốc. Tôi đã gặp nhiều rắc rối tưởng như không thể chịu đựng trước khi hiểu đượcc một sự thật hiển nhiên là Thượng đế trao cho mỗi người một đặc điểm riêng, không ai giống ai. Và, chính vì vậy, tôi không thể đòi hỏi mọi người hành xử giống nhau và mọi người đều biết tự phê phán mình khi họ làm một điều gì đó không tốt”.\r\n\r\nQuả là Wanamaker tài ba đã sớm rút ra được bài học đó trong khi tôi phải mất cả một phần ba thế kỷ mày mò tìm kiếm mới bắt đầu hiểu ra rằng có đến 99% trong chúng ta không bao giờ tự phê phán mình vì bất cứ điều gì, cho dù chúng ta có sai lầm đến đâu đi nữa.\r\n\r\nChỉ trích là vô bổ, nó chỉ gây ra thái độ chống đối và bào chữa. Chỉ trích còn có thể trở nên nguy hiểm vì nó chạm vào lòng kiêu hãnh cố chấp của con ngườii, gây tổn thương tới ý thức về tầm quan trọng của họ và kết cuộc chỉ tạo nên sự tức giận, căm thù. Chỉ trích còn gây phản ứng chối bỏ trách nhiệm, đồng thời phát sinh tâm lý chán nản và nhụt chí trong khi lỗi lầm vẫn không được giải quyết.\r\n\r\nB. F. Skinner, nhà tâm lý học nổi tiếng thế giới đã chứng minh qua thực nghiệm rằng một con thú nuôi được khen vì hành vi tốt sẽ học nhanh và nhớ tốt hơn một con thú bi trừng phạt vì hành vi xấu. Những công trình nghiên cứuu gần đây cho thấy phát hiện này cũng đúng với con người.\r\n\r\nNhà tâm lý học lỗi lạc Hans Selye cho biết: “Nỗi sợ bị lên án ở con người cũng lớn như việc khao khát được tán thưởng”. George B. Johnston ở Enid, Oklahoma, là người phụ trách về an toàn lao động cho công nhân trong một công ty thiết kế. Trách nhiệm quan trọng của ông là làm sao cho các công nhân đội nón bảo hộ mỗi khi họ làm việc ở công trường. Ông kể lại rằng, mỗi khi bắt gặp công nhân không đội nón bảo hộ, ông thường dùng quyền lực ép buộc họ phải tuân theo quy định. Họ miễn cưỡng chấp nhận. Thế nhưng ngay khi ông quay lưng, họ lại cất nón đi. Sau khoá huấn luyện với Dale Carnegie, ông quyết định thử một cách tiếp cận khác. Khi thấy một vài công nhân không đội nón bảo hộ, ông hỏi họ phải chăng chiếc nón không thích hợp hay có điều gì đó không ổn. Sau đó ông nhắc rằng khi làm việc họ nên đội nón bảo hộ để khỏi bị tổn thương hay gặp nguy hiểm khi có sự cố ngoài ý muốn xảy ra. Kết quả là số công nhân chấp nhận đội nón đã tăng lên mà không có sự phản đối hay thái độ khó chịu nào nảy sinh.\r\n\r\nCó thể dễ dàng tìm thấy vô số thất bại do tính cách hay phê phán chỉ trích của con người trong suốt chiều dài lịch sử của mọi dân tộc. Bản chất con người là thế. Những kẻ gây ác, chê trách người khác không bao giờ tự chê trách và nhìn lại mình. Và, những lời chỉ trích giống như chim bồ câu đưa thư, bao giờ cũng quay trở về nơi xuất phát. Có một điều rất nguy hiểm là những người mà ta chỉ trích, lên án, chắc chắn đều sẽ tìm lý lẽ tự biện hộ cho mình và kết án ngược lại chúng ta.\r\n\r\nVào buổi sáng ngày 15 tháng 4 năm 1865, Tổng thống Abraham Lincoln bị John Wilkes Booth ám sát trong căn phòng của một nhà trọ bình dân đối diện với con đường đi từ nhà hát Ford. Nhìn Lincoln bằng ánh mắt kính trọng lẫn tiếc thương sâu sắc, Bộ trưởng Quốc phòng Stanton thốt lên: “Đây là nhà lãnh đạo tuyệt vời nhất của thế giới từ cổ chí kim”.\r\n\r\nBí quyết nào đã tạo nên những thành công của Lincoln trong vai trò lãnh đạo như thế? Theo tôi, chính cách ông đối xử với mọi người đã giúp ông nhận được những tình cảm đặc biệt và lòng tin yêu hết mình của họ. Tuy nhiên, tính cách đó không phải do trời phú mà chính là do ông rèn luyện mà có.\r\n\r\nÍt ai biết rằng trước đây, anh chàng Lincoln khi còn ở thung lũng Pigeon Creek bang Indiana không chỉ thích chỉ trích cay nghiệt mà còn thường viết những bức thư và bài thơ chế nhạo người khác rồi rải ra đường cho mọi người cùng đọc. Cũng ít ai biết rằng, luật sư xuất sắc Lincoln ở Springfield, bang Illinois, rất hay phê phán công khai đối thủ của mình bằng các bài viết đăng trên những tạp chí địa phương. Sự kiêu ngạo và ngông cuồng đó có thể sẽ còn kéo dài hơn nữa, nếu như không có một ngày…\r\n\r\nĐó là một ngày mùa thu năm 1842, chàng trai trẻ hiếu thắng đã chế giếu một chính khách kiêu ngạo tên là James Shields bằng một bài viết không ký tên đăng trên tạp chí Springfield. Cả thành phố cười nhạo James. Thế là, James sục sôi căm phẫn. Bằng mọi giá, ông ta phải tìm cho ra kẻ viết bài báo nọ. Ông phi ngựa đuổi theo Lincoln và ném găng thách Lincoln đấu kiếm vì danh dự. Lincoln không thích đấu kiếm, thậm chí ông đã từng đấu tranh chống lại thủ tục này, nhưng trong hoàn cảnh đó, ông không thể tránh né nếu muốn bảo toàn danh dự. Lincoln đượcc phép chọn vũ khí. Vì có cánh tay rất dài nên ông chọn thanh trường kiếm của kỵ binh và học đấu kiếm cấp tốc từ một người bạn tốt nghiệp trường West Point. Đến hẹn, ông và James ra một bãi cát bên sông Mississippi. May mắn thay, vào phút cuối, những người giúp việc của họ đã giúp cả hai cái đầu đang hừng hực sát khí hiểu ra mọi việc và chấm dứt được cuộc đọ kiếm một mất một còn.\r\n\r\nChỉ đến khi đối diện với ranh giới giữa sự sống và cái chết của chính mình và người khác, Lincoln mới thấy trải nghiệm đó khủng khiếp như thế nào. Cuộc đấu kiếm chết người bất thành đó đã dạy ông một bài học vô giá về cách cư xử với người khác. Từ đó trở đi, Lincoln không bao giờ viết thư lăng mạ bất kỳ ai, không bao giờ chế nhạo ai và gần như không bao giờ chỉ trích ai về bất cứ điều gì nữa.\r\n\r\nTrong suốt cuộc nội chiến ở Mỹ, Lincoln đã từng đề cử các viên tướng McClellan, Pope, Burnside, Hooker, Meade cầm đầu đạo quân Potomac. Mỗi vị tướng đều từng phạm những sai lầm khủng khiếp khiến cho Lincoln nhiều lần rơi vào tình thế tuyệt vọng. Một nửa đất nước kịch liệt lên án những viên tướng bất tài này. Chỉ riêng Lincoln luôn tỏ thiện chí và không hề chỉ trích bất kỳ ai trong số họ. Một trong những câu ông thường hay nói là: “Chúng ta không nên kết án người khác để chính mình không bị kết án”.\r\n\r\nKhi bà Lincoln và nội các của ông lên án gay gắt người dân miền Nam, Lincoln đã khuyên rằng: “Đừng chỉ trích họ. Vì có thể, chúng ta cũng sẽ hành xủ như thế trong những hoàn cảnh tương tự”.\r\n\r\nCó đôi lần, suýt chút nữa chính Lincoln cũng lên tiếng chỉ trích người khác. Nhưng ông đã không chỉ trích mặc dù ông hoàn toàn có lý do chính đáng để làm điều đó.\r\n\r\nTrận Gettysburg diễn ra trong ba ngày đầu tháng 7 năm 1863. Đêm 4 tháng 7, tướng Lee, thuộc quân đội miền Nam, bắt đầu rút quân về phía Nam trong khi mưa bão mang đến những trận mưa như trút nước. Phía trước ông và đoàn quân bại trận là dòng sông Potomac đang thét gào, nước cuồn cuộn sủi bọt trắng xoá. Phía sau là một đạo quân liên minh chiến thắng đang rượt đuổi. Lee bị kẹt ở giữa và hầu như không còn đường thoát. Từ bộ chỉ huy, Lincoln lập tức nhận ra đây là cơ hội vàng để bắt gọn đạo quân của tướng Lee và chấm dứt chiến tranh. Thế là Lincoln ra lệnh cho tướng Meade ngừng triệu tập hội đồng chiến tranh mà lập tức lên đường tấn công Lee. Lincoln đã chuyển lệnh bằng điện tín và sau đó còn cử một đặc phái viên đến gặp Meade yêu cầu phải hành động ngay lập tức.\r\n\r\nNhưng tướng Meade đã làm gì? Ông ta làm ngược lại lệnh của Tổng thống: triệu tập cuộc hộp hội đồng chiến tranh. Không chỉ có vậy, ông ta còn do dự kéo dài thời gian, rồi đánh điện tín từ chối mệnh lệnh của Lincoln. Sáng hôm sau nước rút, tướng Lee vượt sông Potomac với lực lượng toàn vẹn.\r\n\r\nLincoln tức giận điên người, ông gào lên với Robert – con trai mình: “Trời ơi! Cha không thể hiểu nổi! Chúng ta chỉ cần chìa tay ra là tóm gọn tất cả. Vậy mà tất cả những gì cha nói và làm đều không thể khiến cho quân đội tấn công ngay vào kẻ địch. Trong hoàn cảnh thuận lợi đó, bất kỳ viên tướng nào cũng có thể đánh bại Lee. Nếu cha có ở đó, có lẽ cha đã đánh tướng  Meade ngay một trận”.\r\n\r\nTrong nỗi cay đắng và thất vọng tột cùng, Lincoln viết thư cho Meade. Thời kỳ này, Lincoln cực kỳ bảo thủ và rất khó thay đổi suy nghĩ của mình. Chính vì thế bức thư Lincoln viết cho Meade vào năm 1863 chứa đầy những lời lẽ trách móc nặng nề nhất:\r\n\r\n“Tướng quân thân mến! \r\n\r\nTôi không tin là ông không nhận ra hiểm hoạ trong việc để Lee chạy thoát vừa rồi. Ông ta gần như đã nằm trọn trong tay chúng ta. Và nếu bắt được Lee, cuộc nội chiến này có thể đã kết thúc. Thế mà ông đã để vuột mất cơ hội ngàn vàng và cuộc chiến này sẽ không biết còn kéo dài đến bao giờ. Nếu như thứ Hai tuần trước, ông không thể chiến thắng Lee trong những điều kiện thuận lợi như thế, thì bây giờ và về sau, ông có thể làm gì để tấn công được Lee ở phía Nam con sông trong khi ông chỉ còn 2/3 lực lượng mà ông đã từng có? Chẳng có lý do gì tôi có thể hy vọng ông xoay chuyển được tình hình. Ông đã hoàn toàn đánh mất cơ hội ngàn năm có một. Tôi không thể diễn tả được nỗi thất vọng và tức giận của tôi lúc này đối với ông!.” \r\n\r\nCác bạn nghĩ Meade đã làm gì khi đọc bức thư này?\r\n\r\nMeade đã không làm gì cả vì ông ta không bao giờ đọc được bức thư đó! Đơn giản bởi vì Lincoln đã không gửi nó đi. Người ta tìm thấy nó trong những tập hồ sơ của ông sau khi Lincoln qua đời.\r\n\r\nTheo phỏng đoán của tôi – chỉ là phỏng đoán thôi – sau khi viết bức thư này, Lincoln đã nhìn ra ngoài cửa sổ và nhẹ nhàng tự nhủ: “Khoan đã! Có thể mình không nên vội vã như vậy. Chẳng khó gì khi ta ngồi ở đây trong cảnh bình yên của Nhà Trắng để ra lệnh cho Meade tấn công. Nhưng giả sử ta đang ở Gettysburg tuần vừa rồi, tận mắt nhìn thấy cảnh máu đỗ kinh hoàng như Meade đã nhìn thấy, tai nghe tiếng la hét kêu gào của những đồng đội đang hấp hối như Meade đã nghe, thì có lẽ ta cũng sẽ không còn muốn tấn công nữa. Và hơn nữa, nếu như ta có tính nhút nhát, do dự của Meade, có lẽ ta cũng sẽ làm đúng như điều ông ta đã làm. Dẫu sao, sự việc đã rồi, nước đã chảy qua cầu. Nếu bức thư này được gửi đi, ta sẽ hả giận phần nào nhưng Meade có thể tìm cách tự bào chữa hoặc quay lại kết án ta. Điều đó sẽ gây ra những phản ứng tiêu cực, cản trở năng lực của Meade sau này với tư cách là Tổng tư lệnh và biết đâu, tai hại hơn nữa là vì thế mà ông ta có thể bị buộc phải rời khỏi quân đội. Đây là một sai lầm rõ ràng và chắc chắn Meade sẽ tự nhận ra sau này”.\r\n\r\nCó lẽ chính vì những suy nghĩ như vậy mà Lincoln gạt bức thư qua một bên. Ông đã học từ kinh nghiêm cay đắng rằng những lời phê phán và chỉ trích gay gắt hầu như bao giờ cũng mang đến kết quả tiêu cực.\r\n\r\nTheodore Roosevelt kể lại rằng, khi phải đối diện với những vấn đề rắc rối, ông thường ngả người vào ghế và ngước nhìn bức chân dung khổ lớn của Lincoln treo trên bàn làm việc của mình ở Nhà Trắng rồi tự hỏi: ” Lincoln sẽ làm gì nếu ở trong hoàn cảnh này ? Ông sẽ giải quyết vấn đề như thế nào ?“. \r\n\r\nĐại văn hào Mark Twain từng có lần viết thư cho một người làm ông tức điên rằng: “Điều mà anh cần làm lúc này là một giấy phép để tự mai táng. Anh chỉ cần thông báo, tôi sẽ lo được ngay”. Một lần khác, ông viết thư cho một nhà xuất bản về việc người sửa bản in muốn chỉnh sửa lỗi chính tả và cách chấm câu của ông: “Sau này đừng có mà sửa gì trên những tác phẩm của tôi và bảo tay sửa bản thảo ấy hãy giữ lại những ý tưởng điên rồ trong cái đầu tệ hại của hắn cho đến chết đi”. Việc viết những bức thư nặng tính chỉ trích, mỉa mai thậm tệ như thế làm cho Mark Twain cảm thấy dễ chịu hơn. Những lời lẽ cay nghiệt đó giúp ông giải toả được cơn giận. Nhưng may mắn là chúng không gây thiệt hại gì bởi một điều đơn giản là phu nhân của Mark Twain đã kín đáo giữ tất cả chúng lại. Những lá thư đó không bao giờ đến tay người nhận.\r\n\r\nCó người nào bạn đang muốn họ thay đổi và sửa mình để tiến bộ hơn không? Tôi hoàn toàn ủng hộ việc này. Nhưng tại sao lại không bắt đầu  từ bản thân mình? Thay đổi chính mình là một việc có ích và thực tế hơn nhiều so với việc thay đổi người khác và khả năng thành công cũng cao hơn rất nhiều. Khổng Tử từng nói: “Đừng chỉ trích mái nhà hàng xóm nhiều tuyết trong khi cửa nhà mình lại không sạch”.\r\n\r\nNếu như bạn muốn bị ai đó oán hờn dai đẳng hàng chục năm trời và thậm chí có khi đến lúc chết bạn vẫn còn bị thù hận thì hãy tặng cho người ấy những lời phê phán, chỉ trích cay độc, cho dù bạn biết chắc chắn những lời chỉ trích đó là đúng.\r\n\r\nThực ra, con người rất hiếm khi suy xét đúng sai rõ ràng bằng lý trí. Con người thường hay hành xử theo cảm xúc, thành kiến và nhất là cộng thêm lòng kiêu hãnh vốn có của mình nữa.\r\n\r\nLối chỉ trích gay gắt đã khiến cho Thomas Hardy, một trong những tiểu thuyết gia lừng lẫy của văn học Anh phải vĩnh viễn từ bỏ việc viết tiểu thuyết. Cách phê bình cực đoan cũng từng đẩy Thomas Chatterton, nhà thơ Anh, đến chỗ tự sát.\r\n\r\nBenjamin Franklin, một người thô lỗ khi còn trẻ, đã trở thành một nhà ngoại giao tài năng đến mức được chọn làm đại sứ Mỹ ở Pháp. Khi được hỏi về bí quyết thành công, ông đáp: “Tôi không nói xấu ai mà chỉ nói những điều tốt đẹp mà tôi được biết về họ”.\r\n\r\nBất cứ người thiếu suy nghĩ nào cũng có thể chỉ trích, oán trách và than phiền người khác. Và hầu hết những người thiếu suy nghĩ đều làm thế. Nhưng phải là người biết tự chủ và có một tâm hồn bao dung, rộng lượng mới có thể hiểu và biết tha thứ cho người khác.\r\n\r\nVĩ nhân thường biểu lộ sự vĩ đại của mình trong cách đối xử với những con người nhỏ bé. Câu chuyện dưới đây là một minh chứng cụ thể.\r\n\r\nBob Hoover là phi công lái máy bay trình diễn nổi tiếng ở Mỹ. Trong một lần bay thử, khi ông vừa cất cánh và láy được độ cao thì cả hai động cơ của chiếc máy bay đột ngột ngừng hoạt động. Nhờ kinh nghiệm và tài năng khéo léo, ông đã đưa được máy bay đáp xuống đất. Mặc dù không có thiệt hại về nhân mạng nhưng chiếc máy bay gần như hư hỏng hoàn toàn. Hành động đầu tiên của Hoover sau khi đáp khẩn cấp là kiểm tra bình nhiên liệu của máy bay. Đúng như điều ông đã phỏng đoán, bình xăng của chiếc máy bay cánh quạt thời Thế chiến Thứ hai đó không hề chứa xăng – mà thay vào đó là đầy dầu phản lực. Sở dĩ máy bay khởi động lúc đầu được là nhờ phần xăng còn sót lại trước đó. Khi trở về sân bay, ngay lập tức ông đi tìm người thợ máy đã phục vụ máy bay của ông. Anh chàng thợ máy trẻ tuổi đang lo sợ và hối hận đến mức gần như cuồng trí. Khi Hoover đến gần, gương mặt thất thần và hoảng sợ của anh ta ràn rụa nước mắt. Anh ta biết mình vừa gây nên một lỗi lầm không thể tha thứ : làm hỏng một chiếc máy bay rất đắt tiền và suýt chút nữa đã giết chết ba mạng người.\r\n\r\nNgười ta có thể tưởng tượng một cơn nổi giận lôi đình và những lời mắng nhiếc thậm tệ từ người phi công tài ba đầy lòng kiêu hãnh sắp sửa trút xuống người thợ máy đó. Nhưng không, Hoover đã dùng đôi tay to lớn của mình ôm choàng vai người thợ máy ấy và nói: “Tôi tin chắc rằng anh sẽ không bao giờ lặp lại sai sót này nữa. Để minh chứng cho lòng tin của tôi đối với anh, tôi muốn rằng sáng mai anh tiếp tục chuẩn bị cho chiếc  F-51 của tôi”. Tôi tin rằng bạn có thể hình dung sự xúc động và cảm kích vô bờ bến của người thợ máy đối với Hoover sau nghĩa cử bao dung đó.\r\n\r\nCha mẹ thường có xu hướng trách mắng con cái. Tuy nhiên, trước khi bạn la mắng con mình lần sau, xin hãy đọc bài “Cha đã quên”. Bài viết này xuất hiện lần đầu trong Nhật báo People’s Home (People’s Home Journal). Chúng tôi in lại ở đây sau khi đã được phép tác giả.\r\n\r\n“Cha đã quên” là một sáng tác ngắn viết ra trong giây phút cảm xúc chân thành, tác động mạnh mẽ vào nhiều độc giả đến mức được yêu cầu in lại hàng năm. Ngay sau khi xuất hiện lần đầu, bài viết nổi tiếng này đã được đăng trên khắp các tờ báo nước Myõ, được dịch ra nhiều ngôn ngữ khác nhau, đươc truyền bá rộng rãi trong các trường học, nhà thờ, trên các diễn đàn và đã phát trong vô số chương trình truyền thanh, truyền hình. Một điều khá thú vị là các tạp chí định kỳ của các trường trung học và cao đẳng cũng sử dụng bài viết này. Đôi khi một điều nhỏ bé cũng có thể tạo nên những ảnh hưởng lớn lao kfø diệu. Bài viết này thực sự đã tạo nên một phép lạ với những bậc cha mẹ trong gia đình.\r\n\r\n“Con trai yêu quý, con hãy nghe những lời ân hận của cha đây. Cha đã lẻn vào phòng con một mình khi con đang chìm vào giấc ngủ trẻ thơ. Nhìn kìa, một tay con đặt dưới gò má, những lọn tóc hung đẫm mồ hôi bám chặt vào vầng trán ẩm ướt. Chỉ cách đây vài phút thôi, khi cha ngồi trong thư viện và đọc bài viết của mình, nỗi hối hận chợt dâng ngập hồn cha. Và cha đã chạy ngay đến phòng con để xin lỗi. \r\n\r\nCon ơi, cha đã tức giận, quát mắng khi con cầm khăn lau mặt qua quýt trong lúc thay quần áo đi học, lúc con để đôi giầy dơ bẩn hay thấy con vứt vật dụng lung tung trong nhà.\r\n\r\nCha luôn chăm chăm nhìn thấy toàn là lỗi lầm của con. Buổi sáng, cha thấy con không ngăn nắp khi ngủ dậy, lại còn ăn uống vội vàng và lấy một lúc quá nhiều thức ăn vào đĩa. Vì chỉ nhìn thấy lỗi lầm nên khi con chào cha xin phép ra ngoài chơi, cha chỉ chau mày và trả lời cộc lốc không chút thiện cảm : “Hừm ! Liệu mà về sớm đấy !”.\r\n\r\nBuổi chiều, cha cũng tức giận với những sơ suất của con. Khi thấy đôi vớ của con bị rách, cha đã làm con phải mất mặt trước bạn bè khi lôi con về nhà. Con thật sự đã làm cha rất giận dữ vì đã không tiết kiệm, không chịu giữ gìn những món đồ mà cha đã phải vất vả làm việc và dành dụm mua cho con.\r\n\r\nKhi cha đang đọc báo, con rụt rè bước tới ngước nhìn cha với ánh mắt ngây thơ trong sáng, cha lại quát lên : “Mày muốn cái gì?”. Và trái tim cha đã xúc động biết dường nào khi con chỉ im lặng chạy đến, vòng đôi tay bé bỏng ôm cổ cha thật chặt với tất cả yêu thương trìu mến rồi lại chạy biến thật nhanh ra ngoài.\r\n\r\nCon thương yêu !\r\n\r\nCon có biết không, tờ báo đã rời khỏi tay cha trong yên lặng và một nỗi sợ hãi lẫn đau xót nghẹn ngào xâm chiếm cõi lòng cha. Cha đã làm gì thế này ? Cha đã biến mình thành một người cha suốt ngày chỉ săm soi tội lỗi của con mình. Một người cha chỉ toàn tìm kiếm những cái xấu của con để chê trách – và đây lại là phần thưởng mà cha dành cho con nhu là một đứa trẻ ư ? Cha chỉ muốn coi phải thế này thế nọ, cha chỉ muốn con phải cư xử như người lớn. Cha đã đo con bằng cây thước dành cho một người trưởng thành, bằng cả những năm tháng tuổi đời và sự trải nghiệm già dặn của cha.\r\n\r\nCon yêu của cha !\r\n\r\nTrong khi cha nhìn con bằng đôi mắt già cỗi và muộn phiền, đầy thành kiến, soi mói ấy, cha chẳng thèm biết đến những cái tốt, điều hay và chân thành, hồn nhiên trong tư chất của con. Trái tim nhỏ bé của con nồng ấm và to lớn như ánh rạng đông đang tặng bao tia nắng ấm cho những ngọn đồi bao la. Con đã hồn nhiên lao vào hôn chúc cha ngủ ngon mà không hề vướng bận việc cha đã la mắng con cả ngày và hằn học với con vì những lý do không chính đáng.\r\n\r\nCon thương yêu !\r\n\r\nCha không thể đợi thêm được nữa. Cha phải nhanh chóng bước đến bên con, quỳ xuống cạnh chiếc giường nhỏ bé và nhìn khuôn mặt thơ ngây của con trong giấc ngủ với một niềm ân hận vô cùng.\r\n\r\nCó thể, con còn quá bé bỏng để hiểu những cảm xúc đang tràn ngập lòng cha. Cha hứa với con, ngay từ giây phút này, cha sẽ trở lại là người cha đích thực và luôn biết trân trọng tình yêu con ngay cả trong những giây phút nóng giận bừng bừng. Cha sẽ là người bạn trung thành của con, sẽ đau khổ khi con gặp bất hạnh, sẽ cười vui khi con gặp may mắn, sung sướng. Cha sẽ cắn chặt môi để không thốt ra những lời gắt gỏng mỗi khi con quỷ giận dữ trỗi dậy trong lòng cha. Cha sẽ tự bảo mình rằng con vẫn còn bé bỏng.\r\n\r\nÔi, hình như cha đã nhìn đứa con thơ dại của cha như nhìn một con người trưởng thành thật sự. Giờ đây, nhìn con cuộn mình trong chăn và mệt mỏi ngủ yên trên chiếc giường bé xíu, cha chợt nhận ra rằng con chỉ là một đứa trẻ thơ ngây. Sáng sáng, con vẫn nũng nịu trong vòng tay trìu mến của mẹ.  Mái tóc tơ mềm mại của con còn vướng víu trên bờ vai mẹ, cần được che chở trong cảm giác được yêu thương. Vậy mà cha đã đòi hỏi ở con quá nhiều ….\r\n\r\nTôi đã đọc câu chuyện này nhiều lần mà lúc nào cũng nguyên vẹn cảm xúc như lần đầu tiên. Rồi tôi tự hỏi đã bao nhiều lần trong đời, tôi cũng giận dữ vô cớ với những người xung quanh. Hãy thông cảm, thấu hiểu mọi người thay vì oán trách họ. Hãy đặt mình vào vị trí của họ để biết rằng tại sao họ lại có những hành xử như vậy. “Biết mọi thứ cũng có nghĩa là tha thứ mọi thứ“. \r\n\r\nNhư tiến sĩ Johnson đã từng nói : “Ngay cả Chúa Trời còn không xét đoán một người cho đến phút cuối cùng của cuộc đời họ”. Vậy thì tại sao bạn và tôi lại làm điều đó ? \r\n\r\n* Những người bạn gặp trên đường đời sẽ ảnh hưởng đến cuộc sống của bạn. Dù tốt hay xấu, họ cũng tặng cho bạn những kinh nghiệm sống hết sức tuyệt vời. Chính vì vậy, đừng nên lên án, chỉ trích hay than phiền ai cả. Thậm chí, nếu có ai đó làm tổn thương bạn, phản bội bạn, hay lợi dụng lòng tốt của bạn thì xin hãy cứ tha thứ cho họ bởi vì có thể chính nhờ họ mà bạn học được cách khoan dung. \r\n\r\n* Chỉ trích một người là việc không khó, vượt lên trên sự phán xét đó để cư xử rộng lượng, vị tha mới là điều đáng tự hào.', '', 'text'),
(13, 3, 1, 'Chỉ có một cách hiệu quả nhất để khiến một người thực hiện đều ta mong muốn. Và hãy luôn nhớ rằng không có cách nào khác, nếu chúng ta : \r\n\r\n* Một tay giật tóc, một tay gí súng vào đầu một người nào đó và thét lớn : “Có bao nhiêu tài sản, hãy đưa hết cho ta! “; \r\n\r\n * Vênh mặt cau có và thách thức nhân viên của mình : “Nếu không làm việc chăm chỉ, tôi sẽ đuổi việc anh/chị ngay lập tức. Nhìn ra ngoài kia mà xem, biết bao nhiêu người muốn được làm nhân viên của tôi đấy!“; \r\n\r\n * Cầm một cây roi mây to và quát con trai : “Đồ ngu ! Nếu mày còn ham chơi làm dơ bẩn áo quần, tao sẽ cho mày 100 roi“;  \r\n\r\nChúng ta cùng thử hình dung chuyện gì sẽ xảy ra trong ba trường hợp trên ? \r\n\r\nMẫu số chung của cả ba trường hợp là những người bị chúng ta đe doạ sẽ làm theo những gì được yêu cầu. \r\n\r\nNhưng, quan trọng hơn cả là họ sẽ làm với sự chịu đựng, khó chịu, cau có và phẫn uất.Trường hợp xấu hơn nữa là họ sẽ làm ngược lại.\r\n\r\nNgười bị gí súng có thể quật lại người có súng, nhân viên sẽ siêng năng trước mặt và dối trá sau lưng hoặc đi tìm một chỗ làm khác có ông chủ cư xử tốt hơn, còn đứa bé thì sẽ vẫn trốn đi chơi và sau đó lẻn về nhà tắm rửa tươm tất trước khi bạn kịp phát hiện ra nó đã không nghe lời. Thay vì cưỡng bức người khác phải làm theo ý mình, cách đơn giản hơn có thể khiến người khác làm bất cứ điều gì chính là : Hãy để họ làm điều họ muốn. \r\n\r\nNhà phân tâm học lừng danh Sigmund Freud nói rằng: “Mọi  hành động của con người đều xuất phát từ hai động cơ: niềm kiêu hãnh của giới tính và sự khao khát được là người quan trọng”. John Dewey, một trong những nhà triết học sâu sắc nhất của nước Mỹ lại có cách nhìn hơi khác một chút: “Động cơ thúc đẩy sâu sắc nhất trong bản chất con người là sự khao khát được thể hiện mình”.\r\n\r\nVậy bạn khao khát điều gì cho mình? Những đòi hỏi mãnh liệt nào đang bùng cháy trong bạn?\r\n\r\nHầu hết mọi người chúng ta đều mong muốn những điều sau đây:\r\n\r\n \r\n\r\n1. Có được sức khoẻ tốt và một cuộc sống bình an\r\n\r\n \r\n\r\n2. Có những món ăn mình thích\r\n\r\n \r\n\r\n3. Có giấc ngủ ngon\r\n\r\n \r\n\r\n4. Có đầy đủ tiền bạc và tiện nghi vật chất\r\n\r\n \r\n\r\n5. Có cuộc sống tốt đẹp ở kiếp sau\r\n\r\n \r\n\r\n6. Được thoả mãn trong cuộc sống tình dục\r\n\r\n \r\n\r\n7. Con cái khoẻ mạnh, học giỏi\r\n\r\n \r\n\r\n8. Có cảm giác mình là người quan trọng\r\n\r\nHầu hết mọi ước muốn này thường được thoả mãn, chỉ trừ một điều, mà điều ấy cũng sâu sắc, cấp bách như thức ăn hay giấc ngủ nhưng lại ít khi được thoả mãn. Đó là điều mà Freud gọi là “sự khao khát được là người quan trọng” hay là “sự khao khát được thể hiện mình” mà Dewey có nhắc tới. Tổng thống Lincoln viết: “Mọi người đều thích được khen ngợi” còn William James thì tin rằng: “Nguyên tắc sâu sắc nhất trong bản tính con người đó là sự thèm khát được tán thưởng”. Không phải chỉ là “mong muốn”, hay “khao khát” mà là “sự thèm khát” được tán thưởng. “Sự thèm khát” diễn tả một nỗi khao khát dai dẳng mà không được thoả mãn. Và những ai có khả năng thoả mãn được sự thèm khát này một cách chân thành thì người đó sẽ “kiểm soát” được những hành vi của người khác. Sự  khao khát được cảm thấy mình quan trọng là một trong những khác biệt chủ yếu nhất giữa con người và những sinh vật khác.\r\n\r\nKhi tôi còn là một cậu bé ở vùng quê Missouri, cha tôi có nuôi những con heo giống Duoroe Jersey ngộ nghĩnh thuộc nòi mặt trắng. Chúng tôi thường mang những chú heo này và những gia súc khác đến triển lãm ở hội chợ đồng quê cũng như các cuộc triển lãm gia súc khắp vùng Trung Tây. Chúng tôi luôn đứng đầu các cuộc thi với giải thưởng là những dải băng màu lam. Cha tôi thường gắn những dải băng này trên một tấm vải mỏng màu trắng. Khi bạn bè hay khách khứa đến thăm nhà, cha tôi thường mở miếng vải ra khoe. Ông cầm một đầu và tôi cầm đầu kia, rồi ông kể chi tiết với mọi người về từng giải thưởng với niềm tự hào ánh lên trong mắt. Những chú heo chẳng hề quan tâm đến các giải thưởng mà chúng đã giành được. Nhưng cha tôi thì có. Những phần thưởng này khiến ông cảm thấy mình quan trọng.Nếu như tổ tiên chúng ta không có sự khao khát cháy bỏng là cảm thấy mình quan trọng thì sẽ không bao giờ có những nền văn minh độc đáo và loài người chúng ta ngày nay chẳng hơn gì những loài động vật khác. Chính sự khao khát được thấy mình quan trọng đã khiến một nhân viên bán tạp hoá ít học, nghèo khổ chịu khó nghiên cứu những quyển sách luật cũ kỹ mà cậu tình cờ tìm thấy dưới đáy một cái thùng đựng đồ lặt vặt được cậu mua lại với giá 50 xu. Có lẽ các bạn đã nghe nói đến tên anh chàng bán tạp hoá này rồi. Tên anh ta là Lincoln.\r\n\r\nVà cũng chính sự khao khát cảm thấy mình quan trọng đã thúc đẩy Charles Dickens viết nên những tiểu thuyết bất hủ. Sự khao khát này cũng là động lực để Christopher Wren viết những bản giao hưởng của mình lên đá. Và chính sự khao khát ấy cũng đã giúp Rockefeller kiếm được hàng triệu đô-la mà hầu như ông chẳng cần dùng đến một đồng trong số đó!\r\n\r\nKhi chúng ta mặc quần áo thời trang, dùng hàng hiệu, đi những chiếc xe thời thượng, dùng điện thoại di động sành điệu, kể về những đứa con thông minh, chính là lúc chúng ta thể hiện sự khao khát được tỏ ra quan trọng trước mọi người.\r\n\r\nTuy nhiên, nỗi khao khát này cũng có mặt trái của nó. Không ít thanh niên gia nhập các băng nhóm, tham gia những hoạt động tội phạm, sử dụng heroin vào thuốc lắc như để khẳng định mình, để được xã hội nhìn họ như những “Siêu nhân”. E. P. Mulrooney, Uỷ viên Cảnh sát New York, cho biết: Hầu hết những tội phạm trẻ tuổi đều thể hiện cái tôi rất lớn. Yêu cầu đầu tiên của chúng sau khi bị bắt giam là đòi xem những tờ báo tường thuật về chuyện của chúng như thế nào.\r\n\r\nChính cách mỗi người thể hiện sự quan trọng của mình nói lên rất rõ tính cách thật của họ. John D. Rockefeller tìm được cảm giác vềà tầm quan trọng của mình bằng cách đóng góp tiền để dựng nên một bệnh viện hiện đại ở Bắc Kinh để chữa cho hàng triệu người nghèo mà ông chưa bao giờ gặp và cũng chưa hề có ý định gặp. Dillinger thích có được cảm giác về tầm quan trọng của mình bằng cách giết người cướp của. Khi bị FBI (Cục Điều tra Liên bang Mỹ) săn đuổi, hắn ta đã lao vào một trang trại ở Minnesota và dõng dạc tuyên bố: “Ta chính là Dillinger!” với niềm tự hào không cần giấu giếm.\r\n\r\n \r\n\r\nThực ra, đây là một yếu tố rất “người”. Gần như ai cũng thế. Nếu không xem sự khát khao được là người quan trọng là một thuộc tính của con người thì có lẽ nhiều người sẽ kinh ngaïc khi biết rằng, ngay cả những nhân vật nổi tiếng nhất, những con người được tôn vinh nhất trong lịch sử loài người cũng thế. Người ta có thể ngạc nhiên tự hỏi vì sao người vĩ đại như George Washington cũng muốn được gọi là “Đức Ngài Tổng thống Hợp Chủng quốc Hoa Kỳ”. Người ta lại thắc mắc tại sao một con người tài trí như Christopher Columbus cũng muốn có được danh hiệu “Thuỷ sư Đô đốc Đại dương và Phó vương Ấn Độ“. Và, người ta sẽ càng ngạc nhiên hơn nữa nếu biết rằng nữ hoàng Catherine vĩ đại không chịu mở bất kỳ bức thư nào nếu không có lời đề bên ngoài: “Kính gửi Nữ Hoàng Quyền uy”. …\r\n\r\n \r\n\r\nCác nhà tỷ phú chỉ đồng ý tài trợ cho cuộc viễn chinh của thuỷ sư đô đốc Byrd đến Nam Cực năm 1928 với yêu cầu duy nhất là tên của họ phải đượcc đặt cho những dãy núi bằng ở đó. Victor Hugo không khao khát gì hơn là thành phố Paris được đổi thành tên ôn. Ngay cả Shakespeare, người được mệnh danh là người vĩ đại nhất trong số những người vĩ đại, cũng muốn làm vẻ vang thêm tên tuổi của mình bằng cách xin hoàng gia ban cho một tước hiệu quý tộc.\r\n\r\n \r\n\r\nĐôi khi, có người tự biến mình thành tàn tật để có được sự thương hại, sự quan tâm của người khác, để cảm thấy mình quan trọng. Đệ nhất phu nhân McKinley tìm cảm giác quan trọng bằng cách bắt chồng bà, Tổng thống William McKinley của Mỹ, mỗi ngày phải tạm gác việc quốc chính một vài giờ để ở bên giường bà và ru bà ngủ. Bà nuôi dưỡng khao khát cháy bỏng được mọi người chú ý bằng cách yêu cầu ông phải ở bên bà ngay cả khi bà đi khám răng. Có lần, bà đã làm ầm ỉ khi ông “dám” để bà một mình với nha sỉ vì phải tham dự một cuộc họp quan trọng với Bộ trưởng Ngoại giao.\r\n\r\n \r\n\r\nNhà văn Mary Roberts Rinehart có lần kể tôi nghe về một cô gái thông minh và mạnh khoẻ đã trở nên bệnh tật chỉ vì muốn có được cảm giác mình quan trọng. Bà Rinehart kể: “Cô ta nằm lỳ trên giường suốt 10 năm ròng để người mẹ già phải vất vả lên xuống ba tầng lầu phục dịch cô mỗi ngày. Một hôm, người mẹ già mệt mõi đổ bệnh và sau đó qua đời. Trong vài tuần kế đó, cô ta mới ốm liệt giường thực sự. Nhưng rồi cô ta nhanh chóng hồi phục và bắt đầu cuộc sống khoẻ mạnh bình thường như chưa bao giờ ngã bệnh”.\r\n\r\nThậm chí, người ta có thể hoá điên để tìm trong cơn điên cái cảm giác là người quan trọng, điều mà họ không thể có được trong thế giới trần trụi này. Không ít người mải mê “chiến đấu” trong các trò chơi vi tính để biến mình thành anh hùng hảo hán. Trong khi ngoài đời thực họ chỉ là những con  người bình thường, không vai vế, không địa vị xã hội.\r\n\r\nMột vị bác sĩ trưởng khoa thần kinh của một bệnh viên tâm thần uy tín nhất nước Mỹ quả quyết rằng nhiều bệnh nhân đã tìm thấy trong thế giới điên rồ cái cảm giác trở thành một nhân vật quan trọng mà họ không thể có được trong đời thực. Ông kể cho tôi nghe câu chuyện sau: “Gần đây, tôi có một nữ bệnh nhân gặp bi kịch gia đình. Cô ấy muốn được quan tâm, muốn được an ủi, yêu thương. Cô muốn có con cái và có uy tín xã hội, nhưng cuộc sống thực tế đã chà đạp lên tất cả những ước muốn của cô. Chồng cô không yêu cô. Anh ta thậm chí không chịu ngồi ăn cùng cô mà bắt cô phải phục vụ bữa ăn cho anh ta trong một căn phòng trên gác. Cô không có con, cũng không có địa vị xã hội gì cả. Kết quả là cô bị bệnh tâm thần. Trong tưởng tượng của cô, cô thấy mình đã ly dị chồng, trở lại là một con người tự do. Rồi sau đó, cô lại nghĩ rằng mình đã lấy được một người thuộc dòng dõi quý tộc Anh và nhấn mạnh việc mình được gọi là “Phu nhân Smith”. Hơn thế nữa, cô còn hình dung mỗi tối cô có thêm một đứa con. Mỗi lần tôi đến thăm, cô đều nói: “Thưa bác sĩ, tối qua tôi vừa sinh con”.\r\n\r\nCuộc sống đã đẩy mọi con tàu mơ ước của cô va vào những tảng đá sắc cạnh của thực tế. Nhưng tại những hòn đảo tràn ngập  ánh nắng của trí tưởng tượng điên rồ, con tàu mơ ước ấy đã cập bến với cánh buồm phấp phới hoan ca trong gió. Vị băc sĩ khẳng định với tôi: “Nếu như chỉæ cần giơ tay ra là có thể chữa lành căn bệnh cho cô ấy, tôi cúng sẽ không làm. Sống như thế này cô ấy hạnh phúc hơn nhiều”.\r\n\r\nNếu một vài người khao khát cảm giác được trở nên quan trọng đến đỗi hoá điên để có được cảm giác ấy thì bạn hãy hình dung xem, bạn và tôi sẽ đạt được phép mầu gì nếu ta có được điều đó mà không cần phải đến miền điên rồ của trí tưởng tượng?\r\n\r\nMột trong những người đầu tiên ở Mỹ được trả lương trên một triệu đô-la mỗi năm là Charles Schwab (thời mà nước Mỹ chưa có thuế thu nhập cá nhân và một người được xem là giàu có khi mỗi tuần kiếm được 50 đô-la). Ông đã được Andrew Carnegie bổ nhiệm vào chức chủ tịch đầu tiên của Tập đoàn Thép Hoa Kỳ vào năm 1921 khi chỉ mới ba mươi tám tuổi. Vì sao Andrew Carnegie đồng ý trả một triệu đô-la mỗi năm, tức gần 30 ngàn đô-la mỗi ngày cho Charles Schwab? Phải chăng vì Charles Schwab là một thiên tài? Hay vì ông có kiến thức về thép hơn những người khác?\r\n\r\nHoàn toàn không. Chính Charles Schwab bảo tôi rằng, nhiều người làm việc cho ông có kiến thức về chế biến thép hơn hẳn ông. Lý do Schwab được trả lương cao như thế là vì ông có khả năng thu phục lòng người. Ông chia sẽ, bí quyết của ông chính là “khả năng tạo niềm hưng phấn ở những người cùng làm việc, phát huy những ưu điểm mạnh nhất ở một con người bằng cách nhìn nhận, tán thưởng và khuyến khích họ”.\r\n\r\n“Không có cách nào giết chết ước mơ và nỗ lực phấn đấu của con người bằng thái độ và những lời chỉ trích của cấp trên. Tôi không bao giờ chỉ trích một ai. Tôi tin tưởng vào việc tạo ra động lực cho mọi người làm việc. Điều này làm cho tôi luôn mong muốn khen ngợi người khác và không thích làm tổn thương thêm những lỗi lầm của họ. Nếu tôi thích thú một điều gì đó, tôi sẽ  luôn động viên, khuyến khích bằng tất cả sự chân thành và họ hưởng ứng nhiệt tình nhất của mình.”\r\n\r\nĐó là những gì Schwab đã làm. Vậy những người tầm thường ứng xử ra sao? Họ làm ngược lại hoàn toàn. Nếu họ  không thích điều gì, họ sẽ quát mắng nhân viên; còn nếu họ thích, họ sẽ chẳng nói gì. Như một câu nói xưa: “Làm tốt đến đâu, không một  lời khen; sai lầm một lần, nhắc nhở suốt đời.”\r\n\r\nSchwab chia sẻ: “Trong suốt cuộc đời mình, tôi chưa từng gặp người nào làm tốt công việc của mình nếu không có sự ủng hộ của người khác”.\r\n\r\nAndrew Carnegie cũng vậy. Và đó là một trong những lý do làm nên thành công phi thường của “ông vua” thép. Andrew Carnegie khen ngợi những người hợp tác với mình lúc công khai, lúc kín đáo. Thậm chí, ngay cả trên tấm bia mộ của mình, ông còn khen tặng tất cả những người đã từng làm việc cho ông: “Đây là nơi yên nghỉ của một người biết cách tập hợp những người tài giỏi hơn mình”.\r\n\r\nSự khen ngợi, cảm kích thành thực là một trong những bí quyết thành công đầu tiên của John D. Rockefeller trong ứng xử với mọi người. Khi nhân viên của ông là Edward Bedford gây thiệt hại một triệu đô-la trong một vụ mua bán ở Nam Mỹ, thay vì chỉ trích, John D. Rockefeller lại tán thưởng Bedford vì đã cứu được 60% số tiền Rockefeller đã đầu tư. Rockerfeller làm như vậy vì biết rằng Edward đã cố gắng hết sức. Ông nói: “Điều đó thật tuyệt. Chúng ta không phải lúc nào cũng làm tốt được như vậy.”\r\n\r\nTrong số các mẫu báo tôi cắt để lại, có một câu chuyện vui mà tôi biết là không có thực nhưng nó lại minh hoạ cho một sự thật. Tôi sẽ kể lại cho các bạn nghe: Lần nọ, sau một ngày làm việc cực nhọc, vợ một người nông dân đã quẳng trước mặt những người đàn ông trong gia đình bà một đống cỏ khô thay vì dọn bữa ăn tối như mọi khi. Khi họ tức tối hỏi bà có điên hay không, bà đáp: “Tôi đã nấu ăn cho các người suốt 20 năm nay và trong suốt thời gian đó tôi chưa hề nghe ai cám ơn một câu hay nói với tôi rằng các người không biết ăn cỏ khô”. Một công trình nghiên cứu cách đây vài năm về việc những người vợ bỏ nhà ra đi cho thấy nguyên nhân chủ yếu của tình trạng này chính là do “thiếu sự nhìn nhận và trân trọng”. Và tôi chắc chắn rằng nếu có một công trình nghiên cứu về lý do những người chồng bỏ nhà đi thì cũng thu được một kết quả tương tự. Chúng ta thường cho rằng việc vợ hay chồng mình ở bên cạnh là lẽ đương nhiên nên rất hiếm khi dành cho họ một lời cám ơn hay sự trân trọng.\r\n\r\nMột học viên trong lớp của chúng tôi kể rằng vợ anh và một nhóm phụ nữ khác trong nhà thờ cùng tham gia vào một chương trình tự hoàn thiện bản thân. Chị đề nghị anh giúp bằng cách liệt kê sáu điều mà anh cho là chị có thể thay đổi để trở thành một người vợ tốt hơn. Anh ấy kể lại với lớp học như sau: “Tôi ngạc nhiên trước một yêu cầu như vậy. Thú thực, tôi có thể dễ dàng liệt kê sáu điều tôi muốn cô ấy thay đổi. Và, tất nhiên là cô ấy cũng có thể liệt kê một ngàn chuyện cô ấy muốn tôi thay đổi nhưng tôi đã không làm thế. Tôi bảo: “Cho anh suy nghĩ và sáng mai anh sẽ trả lời”. Sáng hôm sau, tôi dậy rất sớm, tìm mua tặng vợ sáu bông hồng với một tấm thiệp ghi: “Anh không thể nghĩ ra sáu điều mà anh muốn em thay đổi. Anh yêu em như chính em bây giờ!”. Chiều hôm đó, khi về nhà, tôi được vợ chào đón bằng những giọt nước mắt đầy xúc động. Không cần  phải nói, tôi vô cùng vui sướng vì đã không phê phán cô ấy như yêu cầu. Chủ nhật sau đó ở nhà thờ, sau khi vợ tôi báo cáo lại kết quả của công việc được giao, nhiều phụ nữ cùng học với cô ấy đã đến gặp tôi và nói: “Từ trước đến nay chúng tôi chưa bao giờ nghe thấy một cử chỉ nào lịch thiệp, chu đáo và ngọt ngào đến như vậy”. Lúc đó tôi mới thật sự hiểu được sức mạnh của sự trân trọng và lòng biết ơn”.\r\n\r\nTôi đã có lần tập theo phong trào nhịn ăn và đã thử sống sáu ngày sáu đêm mà không ăn gì. Thực ra cũng không khó lắm. Cuối ngày thứ sáu, tôi cũng không đói hơn cuối ngày thứ hai. Tuy nhiên, nếu chúng ta để gia đình hay nhân viên của mình nhịn đói sáu ngày thì lại là một lỗi lầm lớn. Thế mà  chúng ta lại để gia đình thân yêu của mình, những nhân viên cần mẫn và tận tuỵ của mình phải nhịn đến sáu tuần hay thậm chí đến sáu mươi năm mà không có đến một lời tán thưởng thật lòng. Chúng ta không chịu nhớ rằng họ đang khao khát đến cháy lòng một lời khen ngợi của chúng ta, chẳng kém gì một người mong có được một bữa ăn ngon lành khi đang đói cồn cào.\r\n\r\nAlfred Lunt, một trong những diễn viên xuất sắc nhất mọi thời đại, người đóng vai chính trong vở kịch Reunion in Vienna, đã nói: “Điều tôi cần hơn cả cho cuộc sống của mình là nuôi dưỡng sự trân trọng đối với bản thân mình”.\r\n\r\nChúng ta nuôi dưỡng phần thể chất của con cái, quan tâm đến cuộc sống vật chất của nhân viên mình nhưng lại rất ít khi nuôi dưỡng hay truyền cho họ sự tự trân trọng những giá trị bản thân. Chúng ta có thể cung cấp cho họ những thức ăn ngon nhưng lại thường quên tặng họ những lời khen ngợi thật lòng mà họ sẽ nhớ mãi như nhớ những giai điệu êm ái tuyệt vời nhất.\r\n\r\nPaul Harvey, trong một buổi phát thanh của mình, đã kể một câu chuyện minh chứng rằng việc khen ngợi, cảm kích thành thật có thể thay đổi cuộc đời một con người như thế nào: “Cách đây nhiều năm có một cô giáo ở Detroit nhờ Stevie Morris giúp cô tìm một con chuột trong lớp học. Cô đánh giá rất cao tài năng của Stevie và khen Stevie rằng Thượng Đế đã tặng cho Stevie một đôi tai thính để bù lại sự khiếm thị. Cô không ngờ rằng đây thực sự là lần đầu tiên Stevie được người khác trân trọng, đánh giá cao về khả năng của đôi tai mình và quên đi sự khiếm khuyết trước giờ. Cho đến bây giờ, Stevie thừa nhận rằng sự trân trọng ngày ấy đã tạo ra một bước ngoặt trong cuộc đời ông. Từ khi được đề cao và phát hiện ra năng khiếu nghe của mình, ông đã nỗ lực phát huy khả năng cho đến khi trở thành một trong những ca sĩ nhạc pop tuyệt vời nhất đồng thời là nhạc sĩ sáng tác những ca khúc hay nhất trong thập niên 70, dưới cái tên huyền thoại Stevie Wonder”.\r\n\r\nKhi đọc những câu chuyện này, có thể bạn sẽ nói: “Trời! Toàn là những lời xu nịnh vô nghĩa! Tôi cũng đã từng thử như vậy. Nhưng cách này thực sự không ổn, đặc biệt với những người nhạy cảm và căm ghét thói giả dối, xu nịnh!”.\r\n\r\nDĩ nhiên, xu nịnh ít khi thành công với những người hiểu biết và có khả năng phân biệt sâu sắc giữa nịnh hót với lời khen ngợi và cám ơn chân thành. Bởi vì tâng bóc chỉ là lời lẽ hời hợt, ích kỷ, hoàn toàn không trung thực, và chắc chắn thất bại. Tuy vậy, cũng có một số người khao khát được tán thưởng đến mức họ nuốt bất kỳ lời khen nào như một người đói ăn cả rau lẫn con  sâu bám trong đó. Tâng bóc giả tạo cũng như tiền giả, nó sẽ gây khó khăn khi chúng ta chuyển nó cho một người nào khác.\r\n\r\nSự khác nhau giữa cảm kích và tâng bóc nằm ở đâu? Rất đơn giản! Điều này là thành thực còn điều kia là không thành thực. Một điều xuất phát từ tấm lòng, một điều chỉ từ cửa miệng. Một điều là vô tư, chân thành, một điều là ích kỹ, có mục đích. Một điều được mọi người cảm nhận, xúc động, một điều thì bị mọi người lên án.\r\n\r\nGần đây tôi được nhìn thấy bức tượng bán thân của một anh hùng Mexico là Tướng Alvaro Obregon tại lâu đài hapultepec ở Mexico. Dưới tượng khắc những lời lẽ đầy triết lý của Obregon: “Đừng sợ những kẻ thù tấn công anh mà hãy sợ những người bạn nịnh hót anh”.\r\n\r\nĐúng! Tôi hoàn toàn không khuyến khích sự xu nịnh! Tôi đang nói đến một cách sống mới. Cho phép tôi nhắc lại: Một cách sống mới.\r\n\r\nVua George V có một loạt sáu câu châm ngôn được viết trên những bức tường trong phòng học của ông tại cung điện Buckingham. Một trong những châm ngôn này viết: “Hãy ngăn tôi đừng trao và nhận những lời khen ngợi rẻ tiền”. Mọi lời nịnh hót đều là lời khen ngợi rẻ tiền. Tôi rất tâm đắc với một định nghĩa cho rằng: “Nịnh hót là nói với một người khác chính điều mà anh ta thích nghĩ về mình”.\r\n\r\nKhi đầu óc không vướng bận, chúng ta thường dành gần 95% thời gian để nghĩ về mình. Hãy ngưng việc nghĩ về bản thân trong chóc lát và bắt đầu nghĩ về điều tốt của những người xung quanh. Khi ấy, tôi và bạn sẽ thấy mình không cần dùng đến những lời nịnh hót nữa. Đó chỉ là một thứ rẻ tiền và giả dối.\r\n\r\nMột trong những giá trị bị chúng ta lãng quên nhiều nhất trong cuộc sống hàng ngày chính là sự cảm kích, trân trọng. Chẳng biết vì sao chúng ta cứ hay quên khen ngợi con cái mình khi nó đem về nhà tờ giấy khen hay quyển sổ liên lạc ghi thành tích học tập tốt trong tháng qua. Chúng ta quên khuyến khích con cái khi lần đầu tiên tự chúng làm được một cái bánh hay tự giác dọn dẹp gọn gàng góc học tập của mình… Không có điều gì làm con trẻ vui sướng hơn là sự quan tâm và khen ngợi của bố mẹ. Mỗi khi thưởng thức một món ngon ở nhà hàng, tôi luôn tự dặn mình nhớ nói với người đầu bếp rằng món ăn ấy rất tuyệt. \r\n\r\nKhi gặp một người bán hàng mệt mỏi mà vẫn biểu lộ sự ân cần với khách thì tôi cũng luôn nhắc nhở mình hãy nhớ cám ơn anh ta vì sự phục vụ tận tâm, nhiệt tình.\r\n\r\nTất cả diễn viên, ca sĩ và diễn giả trên thế giới đều nản lòng nếu không nhận được những tràng vỗ tay khen ngợi nào từ khán thính giả. Nếu điều này đúng đối với những người biểu diễn chuyên nghiệp thì nó còn đúng gắp nhiều lần đối với những người làm việc trong các cơ quan, cửa hàng, nhà máy, trong gia đình và bạn bè chúng ta.\r\n\r\nTrong tất cả quan hệ giữa người với người, chúng ta hãy luôn nhớ rằng mọi người hợp tác với mình cũng đều là những con người và họ đều khao khát nhận được sự công nhận, đánh giá cao và trân trọng vì những gì họ đã làm. \r\n\r\nHãy thắp lên ngọn lửa của sự biết ơn chân thành đối với mọi người trong cuộc sống. \r\n\r\nSự lan toả của ngọn lửa này sẽ mang lại cho bạn những giá  trị vượt thời gian. Chỉ trích hay xúc phạm người khác không bao giờ làm thức tỉnh thay đổi được họ trở nên tốt hơn, vậy nên bạn đừng bao giờ làm thế! Có một câu châm ngôn cổ rất hay mà tôi đã dán lên tấm gương soi để ngày nào cũng có thể nhìn thấy: “Tôi chỉ sống trên thế gian này có một lần, vì vậy nếu có thể làm bất cứ điều tốt đẹp nào hay thể hiện lòng nhân ái, tri ân của mình với bất kỳ ai, tôi sẽ thực hiện ngay không chậm trễ, bởi tôi biết mình sẽ không sống đến lần thứ hai, hoặc sợ mình không còn cơ hội”.\r\n\r\nTriết gia Emerson nói: “Mọi người tôi gặp đều có những điểm hay hơn tôi và tôi luôn học được điều gì đó từ họ”. Mong rằng điều này cũng đúng với bạn và tôi. Chúng ta hãy ngừng nghĩ đến những thành tích, mong muốn của mình và thử tìm hiểu những điểm tốt của người khác. \r\n\r\nMọi người sẽ hết sức ghi nhận những lời khen ngợi của bạn và luôn có động lực để thực hiện những điều tốt đẹp tương tự trong suốt cuộc đời họ.\r\n\r\nBiết khen ngợi và cám ơn những người xung quanh một cách chân thành chính là chiếc đũa thần tạo nên tình thân ái và nguồn động viên tinh thần to lớn. Đó là niềm vui rằng mỗi người đang được quan tâm, công nhận và yêu thương. Mỗi người được khen ngợi chân thành sẽ tự nhiên sửa đổi những tính xấu để trở nên hoàn thiện hơn.\r\n\r\n“Động cơ thúc đẩy sâu sắc nhất trong bản chất con người là sự khao khát được thể hiện mình.” – Nhà triết học Mỹ – John Dewey', '', 'text'),
(15, 12, 2, NULL, '1789926384143_images.jpg', 'image'),
(17, 13, 1, NULL, '1791122082451_canva-watercolor-illustration-of-cute-penguin-MAG9luG_yVg.webp', 'image'),
(18, 14, 1, NULL, '1791122285611_canva-watercolor-illustration-of-cute-penguin-MAG9luG_yVg.webp', 'image'),
(19, 13, 2, NULL, '1791122345563_canva-watercolor-illustration-of-cute-penguin-MAG9luG_yVg.webp', 'image'),
(20, 14, 2, NULL, '1791122384548_1790922506754_135680528658654630_3528342930163089843_29c67ab86c5c85ed056e9345050474ab.jpg', 'image');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `truyen`
--

CREATE TABLE `truyen` (
  `id` int(11) NOT NULL,
  `id_tacgia` int(11) NOT NULL,
  `ten_truyen` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `anh_bia` varchar(255) DEFAULT NULL,
  `luot_xem` int(11) DEFAULT NULL,
  `theloai_ids` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `truyen`
--

INSERT INTO `truyen` (`id`, `id_tacgia`, `ten_truyen`, `mo_ta`, `trang_thai`, `anh_bia`, `luot_xem`, `theloai_ids`) VALUES
(2, 8, 'Thanh Gươm Diệt Quỷ', '', 'hoàn thành', 'uploads/anhbia/6961eed3eb7a1.jpg', NULL, '1'),
(3, 7, 'Naruto', '', 'hoàn thành', 'uploads/anhbia/6965af478a77f.jpg', NULL, NULL),
(4, 7, 'Boruto', '', 'hoàn thành', 'uploads/anhbia/6961eeeb34c90.jpg', NULL, NULL),
(7, 9, 'DragonBall', '', 'hoàn thành', 'uploads/anhbia/696276b9e2fe9.jpg', NULL, NULL),
(8, 6, 'Doremon', 'Đây là tập truyện dài đầu tiên trong bộ Doremon, được phát triển từ truyện ngắn cùng tên \"Chú khủng long của Nobita\" (chương 186). Tiếp theo truyện ngắn này thì sau khi Nobita thả Pisuke về lại kỷ phấn trắng và theo dõi qua vô tuyến thời gian đã phát hiện ra là mình đưa nhầm chú khủng long này về Bắc Mỹ chứ không phải Nhật Bản. Nobita cùng với Doremon, Xuka (Shizuka), Xêkô (Suneo), Chaien (Jaian) đã tức tốc về lại kỷ phấn trắng để đưa Pisuke đến Nhật Bản. Nhưng khi đến nơi thì cỗ máy thời gian bị hư, các bạn đành phải dùng trực thăng tre bay dọc theo bờ biển Bắc Mỹ lên phía bắc để tìm đường về Nhật..', 'đang ra', 'uploads/anhbia/6965afdae12d2.webp', NULL, NULL),
(9, 10, 'Đắc Nhân Tâm', '', 'đang ra', 'uploads/anhbia/6965b26fc91e4.jpg', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `truyen_theloai`
--

CREATE TABLE `truyen_theloai` (
  `id_truyen` int(11) NOT NULL,
  `id_theloai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `truyen_theloai`
--

INSERT INTO `truyen_theloai` (`id_truyen`, `id_theloai`) VALUES
(2, 1),
(2, 3),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(7, 1),
(7, 5),
(8, 1),
(8, 2),
(8, 9),
(8, 10),
(8, 11),
(9, 13),
(9, 14);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_binhluan_nguoidung` (`id_nguoidung`),
  ADD KEY `fk_binhluan_chuong` (`id_chuong`);

--
-- Chỉ mục cho bảng `chuong`
--
ALTER TABLE `chuong`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_truyen` (`id_truyen`,`so_chuong`);

--
-- Chỉ mục cho bảng `hoso_nguoidung`
--
ALTER TABLE `hoso_nguoidung`
  ADD PRIMARY KEY (`id_nguoidung`);

--
-- Chỉ mục cho bảng `layout`
--
ALTER TABLE `layout`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK95b5ldmd6k9b3hpv7vdprd9rm` (`ten_theloai`);

--
-- Chỉ mục cho bảng `luu_trang_doc`
--
ALTER TABLE `luu_trang_doc`
  ADD PRIMARY KEY (`id_nguoidung`,`id_truyen`),
  ADD KEY `fk_luutrang_truyen` (`id_truyen`),
  ADD KEY `fk_luutrang_chuong` (`id_chuong`);

--
-- Chỉ mục cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Chỉ mục cho bảng `tacgia`
--
ALTER TABLE `tacgia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_tacgia` (`ten_tacgia`);

--
-- Chỉ mục cho bảng `theloai`
--
ALTER TABLE `theloai`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_theloai` (`ten_theloai`);

--
-- Chỉ mục cho bảng `theo_doi_truyen`
--
ALTER TABLE `theo_doi_truyen`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `trang`
--
ALTER TABLE `trang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_chuong` (`id_chuong`,`so_trang`);

--
-- Chỉ mục cho bảng `truyen`
--
ALTER TABLE `truyen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_truyen` (`ten_truyen`),
  ADD KEY `id_tacgia` (`id_tacgia`);

--
-- Chỉ mục cho bảng `truyen_theloai`
--
ALTER TABLE `truyen_theloai`
  ADD PRIMARY KEY (`id_truyen`,`id_theloai`),
  ADD KEY `fk_tt_theloai` (`id_theloai`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `chuong`
--
ALTER TABLE `chuong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `layout`
--
ALTER TABLE `layout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `tacgia`
--
ALTER TABLE `tacgia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `theloai`
--
ALTER TABLE `theloai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `theo_doi_truyen`
--
ALTER TABLE `theo_doi_truyen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `trang`
--
ALTER TABLE `trang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `truyen`
--
ALTER TABLE `truyen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  ADD CONSTRAINT `fk_binhluan_chuong` FOREIGN KEY (`id_chuong`) REFERENCES `chuong` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_binhluan_nguoidung` FOREIGN KEY (`id_nguoidung`) REFERENCES `nguoidung` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `chuong`
--
ALTER TABLE `chuong`
  ADD CONSTRAINT `chuong_ibfk_1` FOREIGN KEY (`id_truyen`) REFERENCES `truyen` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `hoso_nguoidung`
--
ALTER TABLE `hoso_nguoidung`
  ADD CONSTRAINT `fk_hoso_nguoidung` FOREIGN KEY (`id_nguoidung`) REFERENCES `nguoidung` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `luu_trang_doc`
--
ALTER TABLE `luu_trang_doc`
  ADD CONSTRAINT `fk_luutrang_chuong` FOREIGN KEY (`id_chuong`) REFERENCES `chuong` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_luutrang_nguoidung` FOREIGN KEY (`id_nguoidung`) REFERENCES `nguoidung` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_luutrang_truyen` FOREIGN KEY (`id_truyen`) REFERENCES `truyen` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `trang`
--
ALTER TABLE `trang`
  ADD CONSTRAINT `trang_ibfk_1` FOREIGN KEY (`id_chuong`) REFERENCES `chuong` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `truyen`
--
ALTER TABLE `truyen`
  ADD CONSTRAINT `truyen_ibfk_1` FOREIGN KEY (`id_tacgia`) REFERENCES `tacgia` (`id`);

--
-- Các ràng buộc cho bảng `truyen_theloai`
--
ALTER TABLE `truyen_theloai`
  ADD CONSTRAINT `fk_tt_theloai` FOREIGN KEY (`id_theloai`) REFERENCES `theloai` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tt_truyen` FOREIGN KEY (`id_truyen`) REFERENCES `truyen` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
