using UnityEngine;

public class Egg : MonoBehaviour
{
    public float waitTimeSeconds;
    public float hatchAnimationTimeSeconds = 0.458f;
    public GameObject turtlePrefab;
    public GameObject eggHatchPrefab;

    private new Animation animation;

    private void Awake()
    {
        animation = GetComponentInChildren<Animation>();
    }

    public void StartEggHatching()
    {
        Invoke("SpawnTurtle", waitTimeSeconds);
        Invoke("PlayHatchAnimation", waitTimeSeconds - hatchAnimationTimeSeconds);
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
    }
}
