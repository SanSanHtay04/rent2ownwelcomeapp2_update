const baseUrl = "https://rto-01-be.vnapp.xyz/api/welcome-app/v1/"; //Staging

//const baseUrl = "https://mmsys-be.vnapp.xyz/api/welcome-app/v1/"; //Production

//Endpoint
const storeSimCardApiEndpoint = "store-sim-card";
const storeContactApiEndpoint = "store-contact";
const storeSMSLogsApiEndpoint = "store-sms-log";
const storeCallLogsApiEndpoint = "store-call-log";
const storeLiveLocationEndpoint = "store-live-location";
const storeFacebookApiEndpoint = "store-facebook";
const storeTiktokApiEndpoint = "store-tiktok";
const postPhoneNoToGetOTPEndpoint = "issue-otp";
const verifyPhoneNoEndpoint = "verify-otp";

//v2
const getApplicationStatusApiEndpoint = "application-status";
const getContractInfoApiEndpoint = "application-status/contract";

//Tiktop
const tiktokBaseUrl = "https://open.tiktokapis.com/v2/";
const getTokenApiEndpoint = "${tiktokBaseUrl}oauth/token/";
const getUserInfoEndpoint =
    "${tiktokBaseUrl}user/info/?fields=open_id,union_id,avatar_url,display_name,profile_deep_link";
const getVideoListEndpoint =
    "${tiktokBaseUrl}video/list/?fields=cover_image_url,id,title,duration,video_description,share_url,embed_link";

//Tiktok App Info
const ttClientKey = "awoxo8pz3rhs65vf";
const ttClientSecret = "92e073f58d67ca613af739854f871181";
const ttGrantType = "authorization_code";
const ttRedirectUrl = "https://r2omm.com/";

//FB App info
const fbAppID = "553045413650886";
const fbAppSecret = "99a0aa8466874e44408f6d8ee2bc0157";

//To check already login or not
const IS_ALD_LOGIN = "r2o_user_is_already_login";
const ACCESS_TOKEN = "Access token";

//Extra Item Vers
const storeCallDurationNFrequencyEndpoint = "store-call-frequency";
const storeTextMsgFrequencyEndpoint = "store-sms-frequency";
const storeAppDownloadHistoryEndpoint = "store-app-download-history";
const storeAppUsagePatternEndpoint = "store-app-usage-pattern";
const storeDeviceInfoEndpoint = "store-device";
