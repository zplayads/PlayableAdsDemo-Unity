using UnityEngine;
using UnityEngine.UI;
using PlayableAds.API;

public class CameraController : MonoBehaviour, IPlayableListener, IPlayableAdapterListener
{
	#region iOS Test ID
	private readonly string iOSDemoAppId = "A650AB0D-7BFC-2A81-3066-D3170947C3DA";
	private readonly string iOSDemoAdUnitId = "BAE5DAAC-04A2-2591-D5B0-38FA846E45E7";
	#endregion

	#region Android Test ID
	private readonly string androidDemoAppId = "5C5419C7-A2DE-88BC-A311-C3E7A646F6AF";
	private readonly string androidDemoAdUnitId = "3FBEFA05-3A8B-2122-24C7-A87D0BC9FEEC";
	#endregion

	public Text cbInfo;
	public Button requestBtn;
	public Button presentBtn;

	void Start()
	{
		requestBtn.onClick.AddListener(RequestAd);
		presentBtn.onClick.AddListener(PresentAd);

		#if UNITY_ANDROID
		PlayableAdsAdapter.Init(gameObject.name, androidDemoAppId);
		PlayableAdsAdapter.AutoloadAd(true);
		PlayableAdsAdapter.CacheCountPerUnitId(1);
		#endif
	}

	private void RequestAd()
	{
		cbInfo.text = "request ad";

		#if UNITY_IOS
		if (!PlayableAdsBridge.IsAutoload())
		{
			PlayableAdsBridge.RequestAd(gameObject.name, iOSDemoAppId, iOSDemoAdUnitId);
		}
		#endif

		#if UNITY_ANDROID
		PlayableAdsAdapter.RequestAd(androidDemoAdUnitId);
		#endif
	}

	private void PresentAd()
	{
		cbInfo.text = "present ad";

		#if UNITY_IOS
		if(PlayableAdsBridge.IsReady()) {
		PlayableAdsBridge.PresentAd();
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

	#region PlayableAds iOS Custom Event

	public void PlayableAdsDidRewardUser(string msg)
	{
		cbInfo.text = "Ad has been presented, giving reward.";
	}

	public void PlayableAdsDidLoad(string msg)
	{
		cbInfo.text = "Ad has been loaded, go present it.";
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
	}

	public void OnLoadFailed(string msg)
	{
		cbInfo.text = "Ad failed to load, info: " + msg;
	}

	public void PlayableAdsIncentive(string msg)
	{
		cbInfo.text = "Ad has been presented, giving reward.";
	}

	public void PlayableAdsMessage(string msg)
	{
		Debug.Log("PlayableAd other callback: " + msg);
	}

	#endregion

}
