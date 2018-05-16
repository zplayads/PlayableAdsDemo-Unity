using UnityEngine;
using UnityEngine.UI;
using PlayableAds.API;

public class CameraController : MonoBehaviour, IPlayableListener, IPlayableAdapterListener
{
	#region iOS Test ID
	private readonly string iOSDemoAppId = "A650AB0D-7BFC-2A81-3066-D3170947C3DA";
	private readonly string iOSDemoAdUnitId = "BAE5DAAC-04A2-2591-D5B0-38FA846E45E7";
	private readonly string iOSTestInterstitial = "0868EBC0-7768-40CA-4226-F9924221C8EB";
	#endregion

	#region Android Test ID
	private readonly string androidDemoAppId = "5C5419C7-A2DE-88BC-A311-C3E7A646F6AF";
	private readonly string androidDemoAdUnitId = "3FBEFA05-3A8B-2122-24C7-A87D0BC9FEEC";
	private readonly string androidTestInterstitial = "19393189-C4EB-3886-60B9-13B39407064E";
	#endregion

	public Text cbInfo;
	public Button requestBtn;
	public Button presentBtn;

	public Button requestInterstitialBtn;
	public Button presentInterstitialBtn;

	void Start()
	{
		requestBtn.onClick.AddListener(RequestAd);
		presentBtn.onClick.AddListener(PresentAd);

		requestInterstitialBtn.onClick.AddListener(RequestInterstitial);
		presentInterstitialBtn.onClick.AddListener(PresentInterstitial);

		#if UNITY_IOS
		PlayableAdsBridge.Init(gameObject.name, iOSDemoAppId);
		#endif

		#if UNITY_ANDROID
		PlayableAdsAdapter.Init(gameObject.name, androidDemoAppId);
		#endif
	}

	private void RequestAd()
	{
		cbInfo.text = "ZPLAYAds ad is loading...";

		#if UNITY_IOS
		PlayableAdsBridge.RequestAd(iOSDemoAdUnitId);
		#endif

		#if UNITY_ANDROID
		PlayableAdsAdapter.RequestAd(androidDemoAdUnitId);
		#endif
	}

	private void RequestInterstitial()
	{
		cbInfo.text = "ZPLAYAds interstitial is loading...";

		#if UNITY_IOS
		PlayableAdsBridge.RequestAd(iOSTestInterstitial);
		#endif

		#if UNITY_ANDROID
		PlayableAdsAdapter.RequestAd(androidTestInterstitial);
		#endif
	}

	private void PresentAd()
	{
		#if UNITY_IOS
		if(PlayableAdsBridge.IsReady(iOSDemoAdUnitId)) {
			PlayableAdsBridge.PresentAd(iOSDemoAdUnitId);
		} else {
			cbInfo.text = "ad not ready.";
		}
		#endif

		#if UNITY_ANDROID
		if(PlayableAdsAdapter.IsReady(androidDemoAdUnitId)) {
			PlayableAdsAdapter.PresentAd(androidDemoAdUnitId);
		} else {
			cbInfo.text = "ad not ready.";
		}
		#endif
	}

	private void PresentInterstitial()
	{
		#if UNITY_IOS
		if(PlayableAdsBridge.IsReady(iOSTestInterstitial)) {
			PlayableAdsBridge.PresentAd(iOSTestInterstitial);
		} else {
			cbInfo.text = "ad not ready.";
		}
		#endif

		#if UNITY_ANDROID
		if(PlayableAdsAdapter.IsReady(androidTestInterstitial)) {
			PlayableAdsAdapter.PresentAd(androidTestInterstitial);
		} else {
			cbInfo.text = "ad not ready.";
		}
		#endif
	}

	#region PlayableAds iOS Custom Event

	public void PlayableAdsDidRewardUser(string msg)
	{
		cbInfo.text = "Ad has been presented, giving reward.";
	}

	public void PlayableAdsDidLoad(string msg)
	{
		cbInfo.text = "Ad has been loaded, go present it.";
		Debug.Log("===> ios key: "+msg);
	}

	public void DidFailToLoadWithError(string error)
	{
		cbInfo.text = "Ad failed to load, info: " + error;
	}
		
	public void PlayableAdsDidStartPlaying(string msg)
	{
		cbInfo.text = "ad did start playing";
	}
		
	public void PlayableAdsDidEndPlaying(string msg)
	{
		cbInfo.text = "ad did end playing";
	}

	public void PlayableAdsDidPresentLandingPage(string msg)
	{
		cbInfo.text = "ad did present landing page";
	}

	public void PlayableAdsDidDismissScreen(string msg)
	{
		cbInfo.text = "ad did dismiss screen";
	}
		
	public void PlayableAdsDidClick(string msg)
	{
		cbInfo.text = "ad did clicked ";
	}

	#endregion

	#region PlayableAds Android Custom Event

	public void OnLoadFinished(string msg)
	{
		cbInfo.text = "Ad has been loaded, go present it.";
		Debug.Log(msg);
	}

	public void OnLoadFailed(string msg)
	{
		cbInfo.text = "Ad failed to load, info: " + msg;
		Debug.Log(msg);
	}

	public void PlayableAdsInstallButtonClicked(string msg){
		cbInfo.text = "Ad failed to load, info: " + msg;
		Debug.Log(msg);
	}

	public void PlayableAdsIncentive(string msg)
	{
		cbInfo.text = "Ad has been presented, giving reward.";
		Debug.Log(msg);
	}

	public void PlayableAdsMessage(string msg)
	{
		Debug.Log("PlayableAd other callback: " + msg);
	}

	#endregion

}
