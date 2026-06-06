-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: forum_app
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `authorId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parentCommentId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `votes` int DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_comments_postId` (`postId`),
  KEY `idx_comments_authorId` (`authorId`),
  KEY `idx_comments_parentCommentId` (`parentCommentId`),
  KEY `idx_comments_createdAt` (`createdAt`),
  CONSTRAINT `Comments_author_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`parentCommentId`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Comments_parent_fk` FOREIGN KEY (`parentCommentId`) REFERENCES `comments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Comments_post_fk` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES ('0f0a513a-7177-4198-aff8-a5eab54f6a95','5aac958c-1056-423c-8273-0d0d4d374908','2284b4b2-f9fd-4a53-b753-1e08328d8511',NULL,'TÔi nghĩ bạn bị gay',0,'2026-06-06 05:48:03','2026-06-06 05:48:03'),('1fc434f2-5e82-4bb4-b0d2-1b8b5fcf1b65','794e8a69-b264-4655-9765-d8bb57851575','2284b4b2-f9fd-4a53-b753-1e08328d8511',NULL,'không phải lo',0,'2026-06-06 05:58:37','2026-06-06 05:58:37'),('22683750-1c25-4383-90ef-4efcfe4abf04','5aac958c-1056-423c-8273-0d0d4d374908','2284b4b2-f9fd-4a53-b753-1e08328d8511',NULL,'TÔi nghĩ bạn bị gay',0,'2026-06-06 05:45:20','2026-06-06 05:45:20'),('410e0836-2c29-49a6-8aeb-d502335ed65b','678ebf81-bfad-43cb-ab5f-1b9bd52e825d','fec56f06-f5e9-4b46-994f-4309cd59d611',NULL,'Bạn có thể dùng cây comment kèm parentId để hiển thị đệ quy.',3,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('706bf223-9f85-4aaa-a1a2-ab64e1d19ca6','44ed50ce-4085-4eba-bebf-4af345d12026','3f351863-a40a-4c69-8b7c-ebfd5129f21a',NULL,'Minh nghi su dung CSS Variables la cach tot nhat.',0,'2026-06-06 05:02:43','2026-06-06 05:02:43'),('87e6a6b0-f211-43c6-934a-a962d9da2702','44ed50ce-4085-4eba-bebf-4af345d12026','2284b4b2-f9fd-4a53-b753-1e08328d8511','8aea9ef2-5910-496c-bde2-97623198b7fb','test',0,'2026-06-06 05:50:22','2026-06-06 05:50:22'),('8aea9ef2-5910-496c-bde2-97623198b7fb','44ed50ce-4085-4eba-bebf-4af345d12026','3f351863-a40a-4c69-8b7c-ebfd5129f21a',NULL,'Thêm một lớp theme biến và lưu trạng thái vào localStorage là ổn.',2,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('9d647edb-c3e6-4e4c-b84f-4692ed3cf019','44ed50ce-4085-4eba-bebf-4af345d12026','a2430259-cd0e-4629-99e8-dc8eeb7f8ae9','8aea9ef2-5910-496c-bde2-97623198b7fb','Mình đồng ý, nên thêm nút chuyển chế độ ngay header.',0,'2026-06-06 04:45:44','2026-06-06 05:52:42'),('a6f6f813-7f5e-4844-b6dd-3ebaad5ba645','44ed50ce-4085-4eba-bebf-4af345d12026','2284b4b2-f9fd-4a53-b753-1e08328d8511','8aea9ef2-5910-496c-bde2-97623198b7fb','đang test',0,'2026-06-06 05:54:31','2026-06-06 05:54:31'),('d03cd0fc-9fa0-4821-84df-330a3f9c21c6','44ed50ce-4085-4eba-bebf-4af345d12026','2284b4b2-f9fd-4a53-b753-1e08328d8511','8aea9ef2-5910-496c-bde2-97623198b7fb','rất ok',0,'2026-06-06 05:49:57','2026-06-06 05:49:57'),('d4529e1c-3548-499c-9ad0-69670b0f266f','5aac958c-1056-423c-8273-0d0d4d374908','3f351863-a40a-4c69-8b7c-ebfd5129f21a',NULL,'Test comment with new notifications',0,'2026-06-06 05:52:58','2026-06-06 05:52:58');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentvotes`
--

DROP TABLE IF EXISTS `commentvotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentvotes` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `voteType` enum('up','down') COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_comment_vote` (`commentId`,`userId`),
  UNIQUE KEY `comment_votes_comment_id_user_id` (`commentId`,`userId`),
  KEY `idx_commentvotes_commentId` (`commentId`),
  KEY `idx_commentvotes_userId` (`userId`),
  KEY `comment_votes_comment_id` (`commentId`),
  KEY `comment_votes_user_id` (`userId`),
  CONSTRAINT `CommentVotes_comment_fk` FOREIGN KEY (`commentId`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commentvotes_ibfk_1` FOREIGN KEY (`commentId`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commentvotes_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CommentVotes_user_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentvotes`
--

LOCK TABLES `commentvotes` WRITE;
/*!40000 ALTER TABLE `commentvotes` DISABLE KEYS */;
INSERT INTO `commentvotes` VALUES ('6894b71c-238e-4582-8569-2a96cc91383a','9d647edb-c3e6-4e4c-b84f-4692ed3cf019','2284b4b2-f9fd-4a53-b753-1e08328d8511','down','2026-06-06 05:52:41','2026-06-06 05:52:42');
/*!40000 ALTER TABLE `commentvotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `recipientId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('NEW_COMMENT','NEW_REPLY','NEW_POST','POST_VOTE','COMMENT_VOTE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `senderId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `commentId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_notifications_recipientId` (`recipientId`),
  KEY `idx_notifications_read` (`read`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`recipientId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`recipientId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`recipientId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Notifications_recipient_fk` FOREIGN KEY (`recipientId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES ('32bb0166-c3be-456f-93cc-c0490f345fb8','a2430259-cd0e-4629-99e8-dc8eeb7f8ae9','NEW_POST','Bài viết \"Làm thế nào để cấu hình Docker cho dự án Node.js?\" của bạn vừa có phản hồi mới.',0,'2026-06-06 05:52:58','2026-06-06 05:52:58',NULL,'Thông báo','5aac958c-1056-423c-8273-0d0d4d374908',NULL,NULL),('59a00223-6262-48d7-adee-e2cf397928da','3f351863-a40a-4c69-8b7c-ebfd5129f21a','NEW_POST','Bình luận của bạn trong \"Cấu hình dark mode cho Ant Design + UmiJS\" vừa có người trả lời.',0,'2026-06-06 05:54:31','2026-06-06 05:54:31',NULL,'Thông báo','44ed50ce-4085-4eba-bebf-4af345d12026',NULL,NULL),('7238531e-61c4-42f5-a359-51cf4e2360a6','fec56f06-f5e9-4b46-994f-4309cd59d611','NEW_POST','Bài viết \"Cấu hình dark mode cho Ant Design + UmiJS\" của bạn vừa có phản hồi mới.',0,'2026-06-06 05:54:31','2026-06-06 05:54:31',NULL,'Thông báo','44ed50ce-4085-4eba-bebf-4af345d12026',NULL,NULL),('9cdd8ef1-1738-4107-bcba-4b859aedbb58','3f351863-a40a-4c69-8b7c-ebfd5129f21a','NEW_POST','Bài viết \"Test Post Title that is 20 chars\" đã được đăng thành công.',0,'2026-06-06 05:53:10','2026-06-06 05:53:10',NULL,'Thông báo','794e8a69-b264-4655-9765-d8bb57851575',NULL,NULL),('f8a0b75e-3191-409c-9a2c-9f6e49558945','3f351863-a40a-4c69-8b7c-ebfd5129f21a','NEW_POST','Bài viết \"Test Post Title that is 20 chars\" của bạn vừa có phản hồi mới.',0,'2026-06-06 05:58:37','2026-06-06 05:58:37',NULL,'Thông báo','794e8a69-b264-4655-9765-d8bb57851575',NULL,NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `authorId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','hidden','deleted') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `votes` int DEFAULT '0',
  `views` int DEFAULT '0',
  `answersCount` int DEFAULT '0',
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_posts_authorId` (`authorId`),
  KEY `idx_posts_title` (`title`),
  KEY `idx_posts_status` (`status`),
  KEY `idx_posts_createdAt` (`createdAt`),
  KEY `idx_posts_votes` (`votes`),
  KEY `idx_posts_views` (`views`),
  CONSTRAINT `Posts_author_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES ('1b66b498-6b76-4ce1-ad65-d5719962c46c','Lỗi kết nối database trong bài tập Docker','Mình đang chạy container MySQL và NodeJS trên local nhưng NodeJS không kết nối được database. Ai biết sửa chỉ mình với.','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,1,0,'tech','2026-06-05 15:37:13','2026-06-05 15:48:35'),('44ed50ce-4085-4eba-bebf-4af345d12026','Cấu hình dark mode cho Ant Design + UmiJS','Dark mode trong forum cần giữ được hiệu ứng nhẹ nhàng và dễ đọc. Mọi người có cách triển khai bằng CSS/LESS không?','fec56f06-f5e9-4b46-994f-4309cd59d611','active',1,98,2,NULL,'2026-06-06 04:45:44','2026-06-06 05:54:17'),('4d39fb70-82ee-40f0-8bc8-d008b1f333c6','Hướng dẫn cài đặt môi trường NodeJS','Mọi người cho mình hỏi cách cài đặt NodeJS phiên bản 20 trên Windows với ạ. Mình cảm ơn!','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,3,0,'general','2026-06-05 15:49:53','2026-06-06 05:33:52'),('5aac958c-1056-423c-8273-0d0d4d374908','Làm thế nào để cấu hình Docker cho dự án Node.js?','Tôi đang gặp khó khăn trong việc thiết lập Dockerfile cho một ứng dụng Node.js sử dụng Express và Prisma. Ai đó có mẫu Dockerfile chuẩn không?','a2430259-cd0e-4629-99e8-dc8eeb7f8ae9','active',0,9,3,'tech','2026-06-06 05:24:47','2026-06-06 05:52:58'),('678ebf81-bfad-43cb-ab5f-1b9bd52e825d','Cách tạo thread comment trong React','Mình cần xây dựng hệ thống bình luận có reply theo luồng. Ai có ví dụ hoặc gợi ý thì share với nhé.','3f351863-a40a-4c69-8b7c-ebfd5129f21a','active',0,128,2,NULL,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('794e8a69-b264-4655-9765-d8bb57851575','Test Post Title that is 20 chars','Test post content that is long enough to pass the validator rules.','3f351863-a40a-4c69-8b7c-ebfd5129f21a','active',1,3,1,'Frontend','2026-06-06 05:53:10','2026-06-06 05:58:39'),('88b0795f-9052-481a-bb5f-757faf3a4e22','Hướng dẫn cài đặt môi trường NodeJS','Mọi người cho mình hỏi cách cài đặt NodeJS phiên bản 20 trên Windows với ạ. Mình cảm ơn!','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,0,0,'tech','2026-06-05 15:49:23','2026-06-05 15:49:23'),('8b75bf80-b151-49e3-98f8-f879f4ba29da','làm sao để code hay','không có gì cho đến khi em nhận ra mình code','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,0,0,'tech','2026-06-05 15:45:55','2026-06-05 15:45:55'),('a24f79eb-a39e-4d85-b817-42ccd0d810fd','Hướng dẫn cài đặt môi trường NodeJS','Mọi người cho mình hỏi cách cài đặt NodeJS phiên bản 20 trên Windows với ạ. Mình cảm ơn!','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,0,0,'general','2026-06-05 15:52:05','2026-06-05 15:52:05'),('aee6f78b-1efe-4774-9bc7-90514230e1e2','làm sao để code hayH','không có gì cho đến khi em nhận ra mình code','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,1,0,'tech','2026-06-05 15:47:44','2026-06-05 15:48:18'),('af70effb-0ed9-4d4f-bfdc-40bf2dbec02b','Làm sao để code hay','Không có gì đáng nói','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,0,0,'tech','2026-06-05 15:44:45','2026-06-05 15:44:45'),('b94f542c-61b1-484c-a7b4-4f948aa35ca5','Hướng dẫn cài đặt môi trường NodeJS','Mọi người cho mình hỏi cách cài đặt NodeJS phiên bản 20 trên Windows với ạ. Mình cảm ơn!','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',2,10,0,'tech','2026-06-05 15:52:12','2026-06-05 15:58:41'),('c05e9250-449e-44ad-a7f2-8445781982b3','Hướng dẫn cài đặt môi trường NodeJS','Mọi người cho mình hỏi cách cài đặt NodeJS phiên bản 20 trên Windows với ạ. Mình cảm ơn!','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,0,0,'tech','2026-06-05 15:49:16','2026-06-05 15:49:16'),('c487a466-d765-4509-9124-90e4f4303817','Hướng dẫn cài đặt môi trường NodeJS','Mọi người cho mình hỏi cách cài đặt NodeJS phiên bản 20 trên Windows với ạ. Mình cảm ơn!','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,3,0,'tech','2026-06-05 15:49:31','2026-06-05 15:58:15'),('daaa2e57-5e5f-49e4-9613-581c36394b06','làm sao để code hayH','không có gì cho đến khi em nhận ra mình code','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,0,0,'tech','2026-06-05 15:48:04','2026-06-05 15:48:04'),('f5503f30-b17d-4742-8917-545fcb6d6261','Hướng dẫn cài đặt môi trường NodeJS','Mọi người cho mình hỏi cách cài đặt NodeJS phiên bản 20 trên Windows với ạ. Mình cảm ơn!','e7e4dfc2-0da5-4883-930e-42b7476002b1','active',0,0,0,'tech','2026-06-05 15:48:58','2026-06-05 15:48:58'),('post-001','Làm thế nào để học ReactJS hiệu quả từ đầu?','<p>Mình đang học năm 3 ngành CNTT và muốn bắt đầu học ReactJS. Các bạn có kinh nghiệm gì chia sẻ không? Mình nên bắt đầu từ đâu, có cần học JavaScript nâng cao trước không?</p>','u-stud-001','active',15,234,3,'tech','2026-05-29 19:23:26','2026-05-29 19:23:26'),('post-002','Điều kiện xét học bổng khuyến khích học tập học kỳ này là gì?','<p>Mình nghe nói học kỳ này có thay đổi về tiêu chí xét học bổng, ai biết thông tin cụ thể không? Điểm GPA tối thiểu là bao nhiêu?</p>','u-stud-002','active',28,513,5,'admin','2026-05-31 19:23:26','2026-06-05 15:48:04'),('post-003','Tìm hiểu về cơ hội thực tập tại các công ty công nghệ lớn','<p>Các bạn đã thực tập ở đâu chưa? Kinh nghiệm thực tập tại các công ty như VNG, FPT, hay startup như thế nào? Chia sẻ để mọi người cùng biết nhé!</p>','u-stud-003','active',42,890,8,'career','2026-06-02 19:23:26','2026-06-02 19:23:26'),('post-004','Lỗi CORS khi gọi API từ React sang Node.js backend','<p>Mình đang làm đồ án môn Web và gặp lỗi <code>Access-Control-Allow-Origin</code> khi gọi API. Backend dùng Express, frontend dùng React + Axios. Làm thế nào để fix?</p><pre><code>Error: CORS policy blocked request from origin http://localhost:3000</code></pre>','u-stud-001','active',19,345,4,'tech','2026-06-03 19:23:26','2026-06-03 19:23:26'),('post-005','Hướng dẫn đăng ký môn học cho sinh viên năm 3','<p>Có bạn nào biết cách đăng ký môn học online cho học kỳ tới không? Mình vào portal nhưng không thấy nút đăng ký, không biết có lỗi gì không?</p>','u-stud-002','active',7,162,2,'admin','2026-06-04 19:23:26','2026-06-06 05:32:58');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posttags`
--

DROP TABLE IF EXISTS `posttags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posttags` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tagId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_post_tag` (`postId`,`tagId`),
  KEY `idx_posttags_postId` (`postId`),
  KEY `idx_posttags_tagId` (`tagId`),
  CONSTRAINT `posttags_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `posttags_ibfk_2` FOREIGN KEY (`tagId`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PostTags_post_fk` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `PostTags_tag_fk` FOREIGN KEY (`tagId`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posttags`
--

LOCK TABLES `posttags` WRITE;
/*!40000 ALTER TABLE `posttags` DISABLE KEYS */;
INSERT INTO `posttags` VALUES ('0cb211c5-43b6-4d9a-9a4e-c8bb31c1f57a','8b75bf80-b151-49e3-98f8-f879f4ba29da','tag-006','2026-06-05 15:45:55','2026-06-05 15:45:55'),('0d2d7eba-1367-45af-b9dc-2abc6b402c0a','aee6f78b-1efe-4774-9bc7-90514230e1e2','tag-003','2026-06-05 15:47:44','2026-06-05 15:47:44'),('18757034-771d-482c-85b0-1ceb220fcc6a','aee6f78b-1efe-4774-9bc7-90514230e1e2','tag-006','2026-06-05 15:47:44','2026-06-05 15:47:44'),('21c56c5f-4df7-4a6c-96ea-8d95a34a35b5','c487a466-d765-4509-9124-90e4f4303817','tag-006','2026-06-05 15:49:31','2026-06-05 15:49:31'),('44dc3a8a-26a4-4695-bf6b-ade42fdb7d32','c487a466-d765-4509-9124-90e4f4303817','tag-003','2026-06-05 15:49:31','2026-06-05 15:49:31'),('4fa5e69e-eb0b-4cd9-9f58-6cd532f05a31','88b0795f-9052-481a-bb5f-757faf3a4e22','tag-006','2026-06-05 15:49:23','2026-06-05 15:49:23'),('57dcb37a-9a40-4a6a-a9c0-6f98d1c9d616','44ed50ce-4085-4eba-bebf-4af345d12026','43b29783-b907-4951-bf14-6b47437c4677','2026-06-06 04:45:44','2026-06-06 04:45:44'),('67315e81-6c60-487a-92b5-68a1282f06c4','c05e9250-449e-44ad-a7f2-8445781982b3','tag-006','2026-06-05 15:49:16','2026-06-05 15:49:16'),('73879aab-a3c6-436f-a33b-9412db7f373b','794e8a69-b264-4655-9765-d8bb57851575','fd919e17-25a3-4eb5-9367-0a015cb7ce6c','2026-06-06 05:53:10','2026-06-06 05:53:10'),('7faea579-e52a-47d0-a64c-40371b5d00a8','678ebf81-bfad-43cb-ab5f-1b9bd52e825d','fbf8f111-49cd-4523-957b-786b7ef93eb4','2026-06-06 04:45:44','2026-06-06 04:45:44'),('84bbcc9c-70e0-4f40-a825-cf4ab0e90abb','1b66b498-6b76-4ce1-ad65-d5719962c46c','6688a7b7-630c-4e2b-b48f-a77783ef9b1a','2026-06-05 15:37:14','2026-06-05 15:37:14'),('9e7e79f3-b06a-4395-8c7f-666f695a4e7a','f5503f30-b17d-4742-8917-545fcb6d6261','tag-006','2026-06-05 15:48:58','2026-06-05 15:48:58'),('b5968c66-303b-4af7-9e98-a4295c654f79','c05e9250-449e-44ad-a7f2-8445781982b3','tag-003','2026-06-05 15:49:16','2026-06-05 15:49:16'),('b5fd891b-047c-4a9d-8876-5cf66d988590','794e8a69-b264-4655-9765-d8bb57851575','6224bf4e-8949-409d-8ebe-e0a0260401cb','2026-06-06 05:53:10','2026-06-06 05:53:10'),('d8ea63d3-0176-43aa-af31-99f5d7a38245','f5503f30-b17d-4742-8917-545fcb6d6261','tag-003','2026-06-05 15:48:58','2026-06-05 15:48:58'),('dc937d2e-b189-49d1-94c1-5e2227dba59c','af70effb-0ed9-4d4f-bfdc-40bf2dbec02b','tag-006','2026-06-05 15:44:45','2026-06-05 15:44:45'),('de25caad-6f7d-40bb-a98b-ad50eeb1abff','daaa2e57-5e5f-49e4-9613-581c36394b06','tag-006','2026-06-05 15:48:04','2026-06-05 15:48:04'),('ebc066ca-f7bf-4f95-aa4d-896d56d00081','88b0795f-9052-481a-bb5f-757faf3a4e22','tag-003','2026-06-05 15:49:23','2026-06-05 15:49:23'),('f7e98e8c-dd4c-461e-a44f-6fe7fde85cd0','daaa2e57-5e5f-49e4-9613-581c36394b06','tag-003','2026-06-05 15:48:04','2026-06-05 15:48:04'),('fee7fdbf-3e7e-4f05-a871-f9177d3a9971','b94f542c-61b1-484c-a7b4-4f948aa35ca5','tag-007','2026-06-05 15:52:12','2026-06-05 15:52:12');
/*!40000 ALTER TABLE `posttags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postvotes`
--

DROP TABLE IF EXISTS `postvotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postvotes` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `voteType` enum('up','down') COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_post_vote` (`postId`,`userId`),
  UNIQUE KEY `post_votes_post_id_user_id` (`postId`,`userId`),
  KEY `idx_postvotes_postId` (`postId`),
  KEY `idx_postvotes_userId` (`userId`),
  KEY `post_votes_post_id` (`postId`),
  KEY `post_votes_user_id` (`userId`),
  CONSTRAINT `postvotes_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `postvotes_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PostVotes_post_fk` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `PostVotes_user_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postvotes`
--

LOCK TABLES `postvotes` WRITE;
/*!40000 ALTER TABLE `postvotes` DISABLE KEYS */;
INSERT INTO `postvotes` VALUES ('12df6522-3dfd-4931-9c85-e578a7b80ab9','794e8a69-b264-4655-9765-d8bb57851575','2284b4b2-f9fd-4a53-b753-1e08328d8511','up','2026-06-06 05:54:40','2026-06-06 05:58:39'),('2ca3df1c-38a7-4530-8eea-1c8c32952387','b94f542c-61b1-484c-a7b4-4f948aa35ca5','2284b4b2-f9fd-4a53-b753-1e08328d8511','up','2026-06-05 15:58:25','2026-06-05 15:58:25'),('2d6bf1a8-ed08-4fa0-a57b-1711c5c5a8d9','5aac958c-1056-423c-8273-0d0d4d374908','3f351863-a40a-4c69-8b7c-ebfd5129f21a','up','2026-06-06 05:30:55','2026-06-06 05:30:55'),('33c716df-b6b7-4ee7-a3c9-ed8bdc52ce0a','44ed50ce-4085-4eba-bebf-4af345d12026','2284b4b2-f9fd-4a53-b753-1e08328d8511','up','2026-06-06 05:51:22','2026-06-06 05:51:43'),('64c425fa-023c-4265-a046-1c54df2e9356','b94f542c-61b1-484c-a7b4-4f948aa35ca5','e7e4dfc2-0da5-4883-930e-42b7476002b1','up','2026-06-05 15:58:39','2026-06-05 15:58:39'),('b84f723e-5add-475e-a03b-ba0fb2609d3a','5aac958c-1056-423c-8273-0d0d4d374908','2284b4b2-f9fd-4a53-b753-1e08328d8511','down','2026-06-06 05:49:18','2026-06-06 05:49:18');
/*!40000 ALTER TABLE `postvotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savedposts`
--

DROP TABLE IF EXISTS `savedposts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savedposts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_saved_post` (`userId`,`postId`),
  KEY `idx_savedposts_userId` (`userId`),
  KEY `idx_savedposts_postId` (`postId`),
  CONSTRAINT `savedposts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `savedposts_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SavedPosts_post_fk` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `SavedPosts_user_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savedposts`
--

LOCK TABLES `savedposts` WRITE;
/*!40000 ALTER TABLE `savedposts` DISABLE KEYS */;
INSERT INTO `savedposts` VALUES ('53a44200-edac-4d2b-a0ae-0adf314d8d48','2284b4b2-f9fd-4a53-b753-1e08328d8511','post-005','2026-06-06 05:33:01','2026-06-06 05:33:01');
/*!40000 ALTER TABLE `savedposts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '#7B61FF',
  `usageCount` int DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `idx_tags_name` (`name`),
  KEY `tags_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES ('43b29783-b907-4951-bf14-6b47437c4677','Backend',NULL,'#7B61FF',0,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('5c5501f4-8aee-4f6b-bd02-2dcd4ddaa9f9','UmiJS',NULL,'#7B61FF',0,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('6224bf4e-8949-409d-8ebe-e0a0260401cb','TypeScript','','#7B61FF',1,'2026-06-06 05:53:10','2026-06-06 05:53:10'),('6688a7b7-630c-4e2b-b48f-a77783ef9b1a','tag-009','','#7B61FF',1,'2026-06-05 15:37:13','2026-06-05 15:37:13'),('fbf8f111-49cd-4523-957b-786b7ef93eb4','Frontend',NULL,'#7B61FF',0,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('fd919e17-25a3-4eb5-9367-0a015cb7ce6c','React',NULL,'#7B61FF',1,'2026-06-06 04:45:44','2026-06-06 05:53:10'),('tag-001','JavaScript','Ngôn ngữ lập trình web phía client','#f7df1e',0,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('tag-002','ReactJS','Thư viện UI của Facebook','#61dafb',0,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('tag-003','NodeJS','Runtime JavaScript phía server','#3c873a',7,'2026-06-05 19:23:26','2026-06-06 05:05:13'),('tag-004','MySQL','Hệ quản trị cơ sở dữ liệu','#4479a1',0,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('tag-005','Python','Ngôn ngữ đa mục đích','#3776ab',0,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('tag-006','Học thuật','Câu hỏi liên quan đến học tập','#fa8c16',8,'2026-06-05 19:23:26','2026-06-05 15:49:31'),('tag-007','Thực tập','Tìm kiếm và kinh nghiệm thực tập','#eb2f96',1,'2026-06-05 19:23:26','2026-06-05 15:52:12'),('tag-008','Quy chế','Quy định, thủ tục nhà trường','#52c41a',0,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('tag-009','Docker','Container và DevOps','#2496ed',1,'2026-06-05 19:23:26','2026-06-06 05:05:13'),('tag-010','Git','Quản lý phiên bản mã nguồn','#f05032',0,'2026-06-05 19:23:26','2026-06-05 19:23:26');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passwordHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('student','lecturer','admin') COLLATE utf8mb4_unicode_ci DEFAULT 'student',
  `status` enum('active','locked') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faculty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `darkMode` tinyint(1) DEFAULT '0',
  `notifications` tinyint(1) DEFAULT '1',
  `bio` text COLLATE utf8mb4_unicode_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `code_2` (`code`),
  KEY `idx_users_email` (`email`),
  KEY `idx_users_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('13f9a83c-79a7-4c36-8e21-d61550622c91','Test student',NULL,'test_student@example.com','$2a$10$d9ezi9bc/3FpTGXAZvnE8.fee8p6cKL77pM7pnK9ujxe8glgm.hii','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-05 16:09:26','2026-06-05 16:09:26'),('2284b4b2-f9fd-4a53-b753-1e08328d8511','Khánh Vũ Duy','B24DCC165','vukhanhtp123@gmail.com','$2a$10$z9/0/bdqiylN3QdMQ8zMeur1oJpvND5sXyGHkIcqqowlyeYAGscXS','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-05 12:29:18','2026-06-05 12:29:18'),('35de250f-05b4-45e9-8679-4728fa405dc3','Admin\' --',NULL,'test_sqli_1@example.com','$2a$10$3dy44l1zANLTwnDkohccDeUvPibBHF6szav4bvmxEEJ3YdcXl2BH.','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-05 16:10:52','2026-06-05 16:10:52'),('3f351863-a40a-4c69-8b7c-ebfd5129f21a','Alice Nguyen',NULL,'alice@example.com','$2a$10$ea/yw2fF3T0odxC5/31Adu0yD6c.ODpZjdBlIINNfKyv5C4gxlnmy','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-06 04:45:44','2026-06-06 05:57:35'),('45447061-5c4e-4bd3-b6c4-787c42a4ad40','Admin\' OR \'1\'=\'1',NULL,'test_sqli_2@example.com','$2a$10$/Wpyok477/JxycsDqOeNiuY7XRlUn/h2./ThJpbk8f1/BqqH4z6Ze','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-05 16:10:52','2026-06-05 16:10:52'),('5dd99bbd-120c-4df2-a4d1-8f69a94a0473','Test Student',NULL,'student@example.com','$2a$10$WZ.tVosUO/e8UwQ/SEb5b.Q3Uw6k7dVQvFSLDH8ibqpQIeMVMfwa.','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-05 16:09:11','2026-06-05 16:09:11'),('91f96099-65f9-4cdb-8477-999497c307d8','Nguyen Van A','B24DCCN999','nguyenvana@student.forum','$2a$10$aSOsrond7G4f8au5JwQYJ.4FR0iJMAmOHxL.FxLl5ZoCp3h36O/du','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-05 15:02:13','2026-06-06 04:52:19'),('a2430259-cd0e-4629-99e8-dc8eeb7f8ae9','Admin Học viện',NULL,'admin@example.com','$2a$10$aWC/p2SLIXkyptgXWwHN9ud6EtlkDoxsysKDP0LFD2fc2ci1PKeF.','admin','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('e7e4dfc2-0da5-4883-930e-42b7476002b1','Test Student','SV20269999','testuser@student.forum','$2a$10$CshDOeFsBjzIv4hqTSpM/eyUEPiZuRQ6zsQK8iaNbSfP1qT4ChGM6','student','active',NULL,'CNTT','D22CQCN01',NULL,0,1,NULL,'2026-06-05 15:32:21','2026-06-05 15:32:21'),('fec56f06-f5e9-4b46-994f-4309cd59d611','Bob Tran',NULL,'bob@example.com','$2a$10$Eptbf.kXzUGX4/eiMOlAku17CCAZVceoAsXCFNRMT70YX/g16QJTi','student','active',NULL,NULL,NULL,NULL,0,1,NULL,'2026-06-06 04:45:44','2026-06-06 04:45:44'),('u-admin-001','Admin Hệ thống',NULL,'admin@hust.edu.vn','$2b$10$PLACEHOLDER_HASH_ADMIN','admin','active',NULL,NULL,NULL,NULL,0,1,'Quản trị viên hệ thống','2026-06-05 19:23:26','2026-06-05 19:23:26'),('u-lect-001','TS. Nguyễn Văn A','GV001','nva@hust.edu.vn','$2b$10$PLACEHOLDER_HASH_LEC1','lecturer','active','Kỹ thuật phần mềm','Công nghệ Thông tin',NULL,NULL,0,1,'Giảng viên môn Lập trình Web và Mobile','2026-06-05 19:23:26','2026-06-05 19:23:26'),('u-lect-002','PGS. Trần Thị B','GV002','ttb@hust.edu.vn','$2b$10$PLACEHOLDER_HASH_LEC2','lecturer','active','Hệ thống thông tin','Công nghệ Thông tin',NULL,NULL,0,1,'Chuyên ngành Cơ sở dữ liệu và AI','2026-06-05 19:23:26','2026-06-05 19:23:26'),('u-stud-001','Lê Văn C','SV20210001','lvc@students.hust.edu.vn','$2b$10$PLACEHOLDER_HASH_SV1','student','active',NULL,'Công nghệ Thông tin','IT-01 K66',NULL,0,1,NULL,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('u-stud-002','Phạm Thị D','SV20210002','ptd@students.hust.edu.vn','$2b$10$PLACEHOLDER_HASH_SV2','student','active',NULL,'Công nghệ Thông tin','IT-02 K66',NULL,0,1,NULL,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('u-stud-003','Hoàng Minh E','SV20210003','hme@students.hust.edu.vn','$2b$10$PLACEHOLDER_HASH_SV3','student','active',NULL,'Điện tử Viễn thông','ET-01 K66',NULL,0,1,NULL,'2026-06-05 19:23:26','2026-06-05 19:23:26'),('u-stud-004','Đỗ Quốc F','SV20200010','dqf@students.hust.edu.vn','$2b$10$PLACEHOLDER_HASH_SV4','student','locked',NULL,'Công nghệ Thông tin','IT-03 K65',NULL,0,1,NULL,'2026-06-05 19:23:26','2026-06-05 19:23:26');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-06 14:51:14
