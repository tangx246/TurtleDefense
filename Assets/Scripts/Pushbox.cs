using UnityEngine;
using DG.Tweening;

public class Pushbox : MonoBehaviour
{
    public float pushStrength = 1f;
    public float pushDuration = 0.25f;

    private new Animation animation;

    private void Awake()
    {
        animation = GetComponentInChildren<Animation>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!enabled)
        {
            return;
        }

        var pushDirection = transform.forward;
        var turtle = other.GetComponentInParent<Turtle>();
        turtle.transform.DOMove(turtle.transform.position + (pushDirection * pushStrength), pushDuration);
        animation.Play();
        enabled = false;
        Destroy(GetComponentInChildren<Collider>().gameObject);
    }
}
