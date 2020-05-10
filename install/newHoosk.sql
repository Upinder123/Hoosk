  -- MySQL Workbench Forward Engineering
  -- Make Sure this file has a Tab in front of each and every line for installer index.php to work
  
  SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
  SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
  SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

  -- -----------------------------------------------------
  -- Schema hoosk
  -- -----------------------------------------------------

  -- -----------------------------------------------------
  -- Table `hoosk_page_attributes`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_page_attributes` ;

  CREATE TABLE IF NOT EXISTS `hoosk_page_attributes` (
    `pageID` INT(11) NOT NULL AUTO_INCREMENT,
    `pagePublished` INT(11) NOT NULL,
    `pageParent` INT(11) NOT NULL,
    `pageTemplate` VARCHAR(250) NOT NULL,
    `pageBanner` INT(11) NOT NULL,
    `pageURL` VARCHAR(250) NOT NULL,
    `enableJumbotron` INT(1) NOT NULL,
    `enableSlider` INT(1) NOT NULL,
    `enableSearch` INT(11) NULL DEFAULT NULL,
    `pageUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    PRIMARY KEY (`pageID`))
  ENGINE = InnoDB
  AUTO_INCREMENT = 11
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_banner`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_banner` ;

  CREATE TABLE IF NOT EXISTS `hoosk_banner` (
    `slideID` INT(11) NOT NULL AUTO_INCREMENT,
    `pageID` INT(11) NOT NULL,
    `slideImage` VARCHAR(350) NOT NULL,
    `slideLink` VARCHAR(350) NOT NULL,
    `slideAlt` VARCHAR(350) NOT NULL,
    `slideOrder` INT(11) NOT NULL,
    PRIMARY KEY (`slideID`, `pageID`),
    INDEX `fk_hoosk_banner_hoosk_page_attributes1_idx` (`pageID` ASC),
    CONSTRAINT `fk_hoosk_banner_hoosk_page_attributes1`
      FOREIGN KEY (`pageID`)
      REFERENCES `hoosk_page_attributes` (`pageID`)
      ON DELETE NO ACTION
      ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 65
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_navigation`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_navigation` ;

  CREATE TABLE IF NOT EXISTS `hoosk_navigation` (
    `id` SMALLINT NOT NULL AUTO_INCREMENT,
    `navSlug` VARCHAR(10) NOT NULL,
    `navTitle` TEXT NOT NULL,
    `navHTML` TEXT NOT NULL,
    `navEdit` TEXT NOT NULL,
    UNIQUE INDEX `navSlug` (`navSlug` ASC),
    FULLTEXT INDEX `navigationHTML` (`navHTML`),
    PRIMARY KEY (`id`))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_jumbotron`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_jumbotron` ;

  CREATE TABLE IF NOT EXISTS `hoosk_jumbotron` (
    `jumbotron_id` INT(11) NOT NULL AUTO_INCREMENT,
    `jumbotron` TEXT NOT NULL,
    `jumbotronHTML` TEXT NOT NULL,
    PRIMARY KEY (`jumbotron_id`))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_page_content`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_page_content` ;

  CREATE TABLE IF NOT EXISTS `hoosk_page_content` (
    `pageID` INT(11) NOT NULL,
    `jumbotron_id` INT(11) NOT NULL,
    `pageTitle` TEXT NOT NULL,
    `navTitle` TEXT NOT NULL,
    `pageContent` TEXT NOT NULL,
    `pageContentHTML` TEXT NOT NULL,
    `pageCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (`pageID`),
    INDEX `fk_hoosk_page_content_hoosk_jumbotron1_idx` (`jumbotron_id` ASC),
    CONSTRAINT `fk_hoosk_page_content_hoosk_page_attributes1`
      FOREIGN KEY (`pageID`)
      REFERENCES `hoosk_page_attributes` (`pageID`)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
    CONSTRAINT `fk_hoosk_page_content_hoosk_jumbotron1`
      FOREIGN KEY (`jumbotron_id`)
      REFERENCES `hoosk_jumbotron` (`jumbotron_id`)
      ON DELETE NO ACTION
      ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_page_meta`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_page_meta` ;

  CREATE TABLE IF NOT EXISTS `hoosk_page_meta` (
    `pageID` INT(11) NOT NULL,
    `pageKeywords` TEXT NOT NULL,
    `pageDescription` TEXT NOT NULL,
    PRIMARY KEY (`pageID`),
    CONSTRAINT `fk_hoosk_page_meta_hoosk_page_attributes`
      FOREIGN KEY (`pageID`)
      REFERENCES `hoosk_page_attributes` (`pageID`)
      ON DELETE NO ACTION
      ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_post_category`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_post_category` ;

  CREATE TABLE IF NOT EXISTS `hoosk_post_category` (
    `categoryID` INT(11) NOT NULL AUTO_INCREMENT,
    `categoryTitle` TEXT NOT NULL,
    `categorySlug` TEXT NOT NULL,
    `categoryDescription` TEXT NOT NULL,
    PRIMARY KEY (`categoryID`))
  ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_post`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_post` ;

  CREATE TABLE IF NOT EXISTS `hoosk_post` (
    `postID` INT(11) NOT NULL AUTO_INCREMENT,
    `categoryID` INT(11) NOT NULL,
    `postURL` TEXT NOT NULL,
    `postTitle` TEXT NOT NULL,
    `postExcerpt` TEXT NOT NULL,
    `postContentHTML` TEXT NOT NULL,
    `postContent` TEXT NOT NULL,
    `postImage` TEXT NOT NULL,
    `published` INT(11) NOT NULL DEFAULT 0,
    `datePosted` VARCHAR(100) NOT NULL,
    `unixStamp` INT(25) NOT NULL,
    PRIMARY KEY (`postID`, `categoryID`),
    INDEX `fk_hoosk_post_hoosk_post_category1_idx` (`categoryID` ASC),
    CONSTRAINT `fk_hoosk_post_hoosk_post_category1`
      FOREIGN KEY (`categoryID`)
      REFERENCES `hoosk_post_category` (`categoryID`)
      ON DELETE NO ACTION
      ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_sessions`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_sessions` ;

  CREATE TABLE IF NOT EXISTS `hoosk_sessions` (
    `id` VARCHAR(40) NOT NULL,
    `ip_address` VARCHAR(45) NOT NULL,
    `timestamp` INT(10) UNSIGNED NOT NULL DEFAULT 0,
    `data` BLOB NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `ci_sessions_timestamp` (`timestamp` ASC))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_settings`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_settings` ;

  CREATE TABLE IF NOT EXISTS `hoosk_settings` (
    `siteID` INT(11) NOT NULL,
    `siteTitle` TEXT NOT NULL,
    `siteDescription` TEXT NOT NULL,
    `siteLogo` TEXT NOT NULL,
    `siteFavicon` TEXT NULL DEFAULT NULL,
    `siteTheme` VARCHAR(250) NOT NULL,
    `siteFooter` TEXT NOT NULL,
    `siteLang` TEXT NOT NULL,
    `siteMaintenance` INT(11) NOT NULL DEFAULT 0,
    `siteMaintenanceHeading` TEXT NOT NULL,
    `siteMaintenanceMeta` TEXT NOT NULL,
    `siteMaintenanceContent` TEXT NOT NULL,
    `siteAdditionalJS` TEXT NOT NULL,
    PRIMARY KEY (`siteID`))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_social`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_social` ;

  CREATE TABLE IF NOT EXISTS `hoosk_social` (
    `id` SMALLINT NOT NULL,
    `socialName` VARCHAR(250) NOT NULL,
    `socialLink` VARCHAR(250) NOT NULL,
    `socialEnabled` INT(11) NOT NULL DEFAULT 0,
    UNIQUE INDEX `socialName` (`socialName` ASC),
    PRIMARY KEY (`id`))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;


  -- -----------------------------------------------------
  -- Table `hoosk_user`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `hoosk_user` ;

  CREATE TABLE IF NOT EXISTS `hoosk_user` (
    `userID` INT(11) NOT NULL AUTO_INCREMENT,
    `userName` VARCHAR(15) NOT NULL,
    `email` VARCHAR(250) NOT NULL,
    `password` VARCHAR(250) NOT NULL,
    `role` VARCHAR(15) NOT NULL,
    `RS` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`userID`))
  ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARACTER SET = utf8mb4;


  SET SQL_MODE=@OLD_SQL_MODE;
  SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
  SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

  -- -----------------------------------------------------
  -- Data for table `hoosk_page_attributes`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_page_attributes` (`pageID`, `pagePublished`, `pageParent`, `pageTemplate`, `pageBanner`, `pageURL`, `enableJumbotron`, `enableSlider`, `enableSearch`, `pageUpdated`) VALUES (1, 1, 0, 'home', 0, 'home', 1, 0, 1, '2017-03-06 21:06:09');
  INSERT INTO `hoosk_page_attributes` (`pageID`, `pagePublished`, `pageParent`, `pageTemplate`, `pageBanner`, `pageURL`, `enableJumbotron`, `enableSlider`, `enableSearch`, `pageUpdated`) VALUES (2, 1, 0, 'page', 0, 'contact', 1, 0, NULL, '2015-01-09 07:09:42');
  INSERT INTO `hoosk_page_attributes` (`pageID`, `pagePublished`, `pageParent`, `pageTemplate`, `pageBanner`, `pageURL`, `enableJumbotron`, `enableSlider`, `enableSearch`, `pageUpdated`) VALUES (3, 1, 0, 'news', 0, 'news', 0, 0, 1, '2016-10-10 20:44:01');

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_navigation`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_navigation` (`id`, `navSlug`, `navTitle`, `navHTML`, `navEdit`) VALUES (1, 'header', 'Header Nav', '<ul class=\"nav navbar-nav\"><li><a href=\"http://beta.hoosk.org\">Home</a></li><li><a href=\"/contact\">Contact</a></li><li><a href=\"/news\">News</a></li></ul>', DEFAULT);
  INSERT INTO `hoosk_navigation` (`id`, `navSlug`, `navTitle`, `navHTML`, `navEdit`) VALUES (2, 'test', 'test', '<ul class=\"nav navbar-nav\"></ul>', DEFAULT);

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_jumbotron`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_jumbotron` (`jumbotron_id`, `jumbotron`, `jumbotronHTML`) VALUES (1, '{\"data\":[{\"type\":\"image_extended\",\"data\":{\"file\":{\"url\":\"http://beta.hoosk.org/images/large_logo.png\",\"filename\":\"large_logo.png\"},\"caption\":\"Hoosk Emblem\",\"source\":\"\"}},{\"type\":\"image_extended\",\"data\":{\"file\":{\"url\":\"http://beta.hoosk.org/images/welcome_to_hoosk.png\",\"filename\":\"welcome_to_hoosk.png\"},\"caption\":\"welcome to hoosk\",\"source\":\"\"}},{\"type\":\"text\",\"data\":{\"text\":\"This demo resets every half hour, the login details are:\\n\\n\"}},{\"type\":\"columns\",\"data\":{\"columns\":[{\"width\":6,\"blocks\":[{\"type\":\"text\",\"data\":{\"text\":\"Username \\\\- demo\\n\\n\"}}]},{\"width\":6,\"blocks\":[{\"type\":\"text\",\"data\":{\"text\":\"Password \\\\- demo\\n\\n\"}}]}],\"preset\":\"columns-6-6\"}},{\"type\":\"button\",\"data\":{\"size\":\"btn-lg\",\"style\":\"btn-primary\",\"is_block\":false,\"url\":\"/admin\",\"null\":\"0\",\"html\":\"Login!\"}}]}', '<img class=\"img-responsive\" src=\"http://beta.hoosk.org/images/large_logo.png\" alt=\"Hoosk Emblem\" /><img class=\"img-responsive\" src=\"http://beta.hoosk.org/images/welcome_to_hoosk.png\" alt=\"welcome to hoosk\" /><p>This demo resets every half hour, the login details are:</p><div class=\'row\'><div class=\'col-md-6\'><p>Username &#45; demo</p></div><div class=\'col-md-6\'><p>Password &#45; demo</p></div></div><a href=\"/admin\" class=\"btn btn-primary btn-lg\">Login!</a>');
  INSERT INTO `hoosk_jumbotron` (`jumbotron_id`, `jumbotron`, `jumbotronHTML`) VALUES (2, '{\"data\":[{\"type\":\"image_extended\",\"data\":{\"file\":{\"url\":\"http://beta.hoosk.org/images/large_logo.png\",\"filename\":\"large_logo.png\"},\"caption\":\"Hoosk Emblem\",\"source\":\"\"}}]}', '<img class=\"img-responsive\" src=\"http://beta.hoosk.org/images/large_logo.png\" alt=\"Hoosk Emblem\" />');
  INSERT INTO `hoosk_jumbotron` (`jumbotron_id`, `jumbotron`, `jumbotronHTML`) VALUES (3, DEFAULT, DEFAULT);

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_page_content`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_page_content` (`pageID`, `jumbotron_id`, `pageTitle`, `navTitle`, `pageContent`, `pageContentHTML`, `pageCreated`) VALUES (1, 1, 'Hoosk Demo', 'Home', '{\"data\":[{\"type\":\"columns\",\"data\":{\"columns\":[{\"width\":6,\"blocks\":[{\"type\":\"heading\",\"data\":{\"text\":\"This is the Hoosk demo site.\\n\",\"heading\":\"\"}},{\"type\":\"text\",\"data\":{\"text\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quam nisl, sodales id lobortis quis, dapibus quis mauris. Fusce sed placerat risus. Pellentesque imperdiet ex et libero eleifend, ac mattis tortor ultricies. Donec vel ullamcorper purus. Vestibulum dignissim ipsum quis porta finibus.\\n\\n\"}},{\"type\":\"text\",\"data\":{\"text\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quam nisl, sodales id lobortis quis, dapibus quis mauris. Fusce sed placerat risus. Pellentesque imperdiet ex et libero eleifend, ac mattis tortkjor ultricies. Donec vel ullamcorper purus. Vestibulum dignissim ipsum quis porta finibus.\\n\\n\"}}]},{\"width\":6,\"blocks\":[{\"type\":\"image_extended\",\"data\":{\"file\":{\"url\":\"http://beta.hoosk.org/images/responsive_hoosk.png\",\"filename\":\"responsive_hoosk.png\"},\"caption\":\"Hoosk is responsive\",\"source\":\"\"}}]}],\"preset\":\"columns-6-6\"}}]}', '<div class=\'row\'><div class=\'col-md-6\'><>This is the Hoosk demo site.</><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quam nisl, sodales id lobortis quis, dapibus quis mauris. Fusce sed placerat risus. Pellentesque imperdiet ex et libero eleifend, ac mattis tortor ultricies. Donec vel ullamcorper purus. Vestibulum dignissim ipsum quis porta finibus.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quam nisl, sodales id lobortis quis, dapibus quis mauris. Fusce sed placerat risus. Pellentesque imperdiet ex et libero eleifend, ac mattis tortkjor ultricies. Donec vel ullamcorper purus. Vestibulum dignissim ipsum quis porta finibus.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quam nisl, sodales id lobortis quis, dapibus quis mauris. Fusce sed placerat risus. Pellentesque imperdiet ex et libero eleifend, ac mattis tortkjor ultricies. Donec vel ullamcorper purus. Vestibulum dignissim ipsum quis porta finibus.</p></div><div class=\'col-md-6\'><img class=\"img-responsive\" src=\"http://beta.hoosk.org/images/responsive_hoosk.png\" alt=\"Hoosk is responsive\" />', '2014-11-03 02:22:20');
  INSERT INTO `hoosk_page_content` (`pageID`, `jumbotron_id`, `pageTitle`, `navTitle`, `pageContent`, `pageContentHTML`, `pageCreated`) VALUES (2, 2, 'Contact', 'Contact', '{\"data\":[{\"type\":\"heading\",\"data\":{\"text\":\"Contact\"}},{\"type\":\"text\",\"data\":{\"text\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quam nisl, sodales id lobortis quis, dapibus quis mauris. Fusce sed placerat risus. Pellentesque imperdiet ex et libero eleifend, ac mattis tortor ultricies. Donec vel ullamcorper purus. Vestibulum dignissim ipsum quis porta finibus.\\n\"}}]}', '<h2>Contact</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quam nisl, sodales id lobortis quis, dapibus quis mauris. Fusce sed placerat risus. Pellentesque imperdiet ex et libero eleifend, ac mattis tortor ultricies. Donec vel ullamcorper purus. Vestibulum dignissim ipsum quis porta finibus.</p>', '2014-11-04 11:54:54');
  INSERT INTO `hoosk_page_content` (`pageID`, `jumbotron_id`, `pageTitle`, `navTitle`, `pageContent`, `pageContentHTML`, `pageCreated`) VALUES (3, 1, 'News', 'News', '', '', '2014-12-03 06:47:20');

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_page_meta`
  -- -----------------------------------------------------
  START TRANSACTION;
 
  INSERT INTO `hoosk_page_meta` (`pageID`, `pageKeywords`, `pageDescription`) VALUES (1, 'Hoosk Keywords', 'Hoosk Description');
  INSERT INTO `hoosk_page_meta` (`pageID`, `pageKeywords`, `pageDescription`) VALUES (2, 'Contact', 'Contact');
  INSERT INTO `hoosk_page_meta` (`pageID`, `pageKeywords`, `pageDescription`) VALUES (3, 'test', 'test');

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_post_category`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_post_category` (`categoryID`, `categoryTitle`, `categorySlug`, `categoryDescription`) VALUES (1, 'Uncategorized', 'uncategorized-asd', 'This is the default category for things that dont quite fit anywhere');
  INSERT INTO `hoosk_post_category` (`categoryID`, `categoryTitle`, `categorySlug`, `categoryDescription`) VALUES (2, 'Hoosk Updates', 'hoosk_updates', 'Latest hoosk updates');
  INSERT INTO `hoosk_post_category` (`categoryID`, `categoryTitle`, `categorySlug`, `categoryDescription`) VALUES (3, 'FAQs', 'faqs', 'Hoosk FAQs');
  INSERT INTO `hoosk_post_category` (`categoryID`, `categoryTitle`, `categorySlug`, `categoryDescription`) VALUES (4, 'Test Category', 'test', 'test');

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_post`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_post` (`postID`, `categoryID`, `postURL`, `postTitle`, `postExcerpt`, `postContentHTML`, `postContent`, `postImage`, `published`, `datePosted`, `unixStamp`) VALUES (3, 3, 'yes_i_used_a_machine_gun', 'Yes, I used a machine gun.', 'You wouldn\'t hit a man with no trousers on, would you? You\'re only supposed to blow the bloody doors off! You know, your bobby dangler, giggle stick, your general-two-colonels, master of ceremonies... Yeah,', '<div class=\'row\'><div class=\'col-md-6\'><p>You\'re only supposed to blow the bloody doors off! Jasper: Your baby is the miracle the whole world has been waiting for. Yes, I used a machine gun. You know, your bobby dangler, giggle stick, your general&#45;two&#45;colonels, master of ceremonies... Yeah, don\'t be shy, let\'s have a look. My lord! You\'re a tripod. My lord! You\'re a tripod. I took a Viagra, got stuck in me throat, I\'ve had a stiff neck for hours. When I get back, remind to tell you about the time I took 100 nuns to Nairobi! At this point, I\'d set you up with a chimpanzee if it\'d brought you back to the world! Pull my finger! It\'s not the size mate, it\'s how you use it. You wouldn\'t hit a man with no trousers on, would you? </p>', '{\"data\":[{\"type\":\"columns\",\"data\":{\"columns\":[{\"width\":6,\"blocks\":[{\"type\":\"text\",\"data\":{\"text\":\" You\'re only supposed to blow the bloody doors off! Jasper: Your baby is the miracle the whole world has been waiting for. Yes, I used a machine gun. You know, your bobby dangler, giggle stick, your general\\\\-two\\\\-colonels, master of ceremonies... Yeah, don\'t be shy, let\'s have a look. My lord! You\'re a tripod. My lord! You\'re a tripod. I took a Viagra, got stuck in me throat, I\'ve had a stiff neck for hours. When I get back, remind to tell you about the time I took 100 nuns to Nairobi! At this point, I\'d set you up with a chimpanzee if it\'d brought you back to the world! Pull my finger! It\'s not the size mate, it\'s how you use it. You wouldn\'t hit a man with no trousers on, would you? \\n\\n\"}}]},{\"width\":6,\"blocks\":[{\"type\":\"text\",\"data\":{\"text\":\"Your were only supposed to blow the bloody doors off. My lord! You\'re a tripod. When I get back, remind to tell you about the time I took 100 nuns to Nairobi! It\'s not the size mate, it\'s how you use it. At this point, I\'d set you up with a chimpanzee if it\'d brought you back to the world! \\n\"}},{\"type\":\"heading\",\"data\":{\"text\":\"Hola Mundo!!!\",\"heading\":\"\"}}]}],\"preset\":\"columns-6-6\"}}]}', 'jumbotron.jpg', 1, '06/12/2014 03:30', 1402540200);
  INSERT INTO `hoosk_post` (`postID`, `categoryID`, `postURL`, `postTitle`, `postExcerpt`, `postContentHTML`, `postContent`, `postImage`, `published`, `datePosted`, `unixStamp`) VALUES (1, 1, 'hello_hoosk', 'Hello Hoosk.', 'Brain freeze. Kinda hot in these rhinos. Here she comes to wreck the day. Brain freeze. Excuse me, I\'d like to ASS you a few questions.', '<div class=\'row\'><div class=\'col-md-6\'><p>Brain freeze. Kinda hot in these rhinos. Here she comes to wreck the day. Brain freeze. Excuse me, I\'d like to ASS you a few questions. We\'re going for a ride on the information super highway. Your entrance was good, his was better. Kinda hot in these rhinos. It\'s because i\'m green isn\'t it! Here she comes to wreck the day. Alrighty Then Excuse me, I\'d like to ASS you a few questions. </p>', '{\"data\":[{\"type\":\"columns\",\"data\":{\"columns\":[{\"width\":6,\"blocks\":[{\"type\":\"text\",\"data\":{\"text\":\"Brain freeze. Kinda hot in these rhinos. Here she comes to wreck the day. Brain freeze. Excuse me, I\'d like to ASS you a few questions. We\'re going for a ride on the information super highway. Your entrance was good, his was better. Kinda hot in these rhinos. It\'s because i\'m green isn\'t it! Here she comes to wreck the day. Alrighty Then Excuse me, I\'d like to ASS you a few questions. \\n\"}},{\"type\":\"button\",\"data\":{\"size\":\"\",\"style\":\"btn-default\",\"is_block\":false,\"url\":\"www.google.com\",\"null\":\"0\",\"html\":\"Button\"}}]},{\"width\":6,\"blocks\":[{\"type\":\"text\",\"data\":{\"text\":\"Your entrance was good, his was better. We got no food we got no money and our pets heads are falling off! Haaaaaaarry. Look at that, it\'s exactly three seconds before I honk your nose and pull your underwear over your head. It\'s because i\'m green isn\'t it! Hey, maybe I will give you a call sometime. Your number still 911? Excuse me, I\'d like to ASS you a few questions. \\n\"}}]}],\"preset\":\"columns-6-6\"}}]}', 'large_logo.png', 0, '12/17/2016 22:12:23', 1482012743);
  INSERT INTO `hoosk_post` (`postID`, `categoryID`, `postURL`, `postTitle`, `postExcerpt`, `postContentHTML`, `postContent`, `postImage`, `published`, `datePosted`, `unixStamp`) VALUES (2, 2, 'me_im_dishonest', 'Me? I\'m dishonest', 'A drug person can learn to cope with things like seeing their dead grandmother crawling up their leg with a knife in her teeth. But no one should be asked to handle this trip. Well, then, I confess, it is my intention to commandeer one of these ships, pick up a crew in Tortuga, raid, pillage, plunder and otherwise pilfer my weasely black guts out.', '', '', 'responsive_hoosk.png', 1, '06/12/2014 02:58', 1402538280);

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_settings`
  -- -----------------------------------------------------
  START TRANSACTION;
 
  INSERT INTO `hoosk_settings` (`siteID`, `siteTitle`, `siteDescription`, `siteLogo`, `siteFavicon`, `siteTheme`, `siteFooter`, `siteLang`, `siteMaintenance`, `siteMaintenanceHeading`, `siteMaintenanceMeta`, `siteMaintenanceContent`, `siteAdditionalJS`) VALUES (0, 'hoosk', 'Hoosk', 'logo.png', 'favicon.png', 'dark', '&copy; Hoosk CMS 2017', 'english/', 0, 'Down for maintenance', 'Down for maintenance', 'This site is currently down for maintenance, please check back soon.', DEFAULT);

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_social`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (2, 'facebook', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (3, 'google', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (4, 'pinterest', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (5, 'foursquare', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (6, 'linkedin', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (7, 'myspace', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (8, 'soundcloud', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (9, 'spotify', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (10, 'lastfm', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (11, 'youtube', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (12, 'vimeo', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (13, 'dailymotion', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (14, 'vine', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (15, 'flickr', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (16, 'instagram', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (17, 'tumblr', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (18, 'reddit', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (19, 'envato', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (20, 'github', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (21, 'tripadvisor', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (22, 'stackoverflow', DEFAULT, 0);
  INSERT INTO `hoosk_social` (`id`, `socialName`, `socialLink`, `socialEnabled`) VALUES (23, 'persona', DEFAULT, 0);

  COMMIT;


  -- -----------------------------------------------------
  -- Data for table `hoosk_user`
  -- -----------------------------------------------------
  START TRANSACTION;
  
  INSERT INTO `hoosk_user` (`userID`, `userName`, `email`, `password`, `role`, `RS`) VALUES (2, 'demo', 'info@hoosk.org', '76d1e5ade32152e80c4e3aa926d51c44', 'owner', DEFAULT);
  INSERT INTO `hoosk_user` (`userID`, `userName`, `email`, `password`, `role`, `RS`) VALUES (1, 'webcurators', 'thewebcurators@gmail.com', '1234', 'admin', DEFAULT);

  COMMIT;

