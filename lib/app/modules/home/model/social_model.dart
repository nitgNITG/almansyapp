class SocialMediaModel {
  final String? cocoonFacebookUrl;
  final String? cocoonTwitterUrl;
  final String? cocoonInstagramUrl;
  final String? cocoonYoutubeUrl;
  final String? cocoonSnapchatUrl;
  final String? cocoonTiktokUrl;
  final String? cocoonWhatsappUrl;
  final String? cocoonTelegramUrl;

  const SocialMediaModel(
      {this.cocoonFacebookUrl,
      this.cocoonTwitterUrl,
      this.cocoonInstagramUrl,
      this.cocoonYoutubeUrl,
      this.cocoonSnapchatUrl,
      this.cocoonTiktokUrl,
      this.cocoonWhatsappUrl,
      this.cocoonTelegramUrl});

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      cocoonFacebookUrl: json['cocoon_facebook_url'],
      cocoonTwitterUrl: json['cocoon_twitter_url'],
      cocoonInstagramUrl: json['cocoon_instagram_url'],
      cocoonYoutubeUrl: json['cocoon_youtube_url'],
      cocoonSnapchatUrl: json['cocoon_snapchat_url'],
      cocoonTiktokUrl: json['cocoon_tiktok_url'],
      cocoonWhatsappUrl: json['cocoon_whatsapp_url'],
      cocoonTelegramUrl: json['cocoon_telegram_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cocoon_facebook_url': cocoonFacebookUrl,
      'cocoon_twitter_url': cocoonTwitterUrl,
      'cocoon_instagram_url': cocoonInstagramUrl,
      'cocoon_youtube_url': cocoonYoutubeUrl,
      'cocoon_snapchat_url': cocoonSnapchatUrl,
      'cocoon_tiktok_url': cocoonTiktokUrl,
      'cocoon_whatsapp_url': cocoonWhatsappUrl,
      'cocoon_telegram_url': cocoonTelegramUrl,
    };
  }
}
