using System.Collections;
using TMPro;
using UnityEngine;
using UnityTools;

public class Egg : MonoBehaviour
{
    public float waitTimeSeconds;
    public float hatchAnimationTimeSeconds = 0.458f;
    public GameObject turtlePrefab;
    public GameObject eggHatchPrefab;
    public AudioClips audioClips;
    public TMP_Text timerText;

    private new Animation animation;

    private void Awake()
    {
        animation = GetComponentInChildren<Animation>();
        audioClips = GetComponentInChildren<AudioClips>();
        timerText.text = waitTimeSeconds.ToString("F1");
    }

    public void StartEggHatching()
    {
        Invoke("SpawnTurtle", waitTimeSeconds);
        Invoke("PlayHatchAnimation", waitTimeSeconds - hatchAnimationTimeSeconds);

        StartCoroutine(StartCountdownTimer());
    }

    private IEnumerator StartCountdownTimer()
    {
        while(waitTimeSeconds > 0)
        {
            timerText.text = waitTimeSeconds.ToString("F1");
            waitTimeSeconds = Mathf.Max(waitTimeSeconds - 0.1f, 0);
            yield return new WaitForSeconds(0.1f);
        }
    }

    void SpawnTurtle()
    {
        // Spawn the turtle
        Instantiate(turtlePrefab, transform.position, transform.rotation);
        // Destroy the egg
        Destroy(gameObject);

        Instantiate(eggHatchPrefab, transform.position, transform.rotation);
    }

    private void PlayHatchAnimation()
    {
        animation.Play(PlayMode.StopAll);
        audioClips.PlayClip("wobble");
    }
}
