using UnityEngine;
using DG.Tweening;

public class Pushbox : MonoBehaviour
{
    public float pushStrength = 1f;
    public float pushDuration = 0.25f;
    public LayerMask turtleMask;

    private new Animation animation;

    private void Awake()
    {
        animation = GetComponentInChildren<Animation>();
    }

    private void OnTriggerEnter(Collider _)
    {
        if (!enabled)
        {
            return;
        }

        var selfCollider = GetComponentInChildren<BoxCollider>();

        var turtles = Physics.OverlapBox(selfCollider.transform.position, selfCollider.size, selfCollider.transform.rotation, turtleMask);

        foreach (var other in turtles)
        {
            var pushDirection = transform.forward;
            var turtle = other.GetComponentInParent<Turtle>();
            turtle.transform.DOMove(turtle.transform.position + (pushDirection * pushStrength), pushDuration);
            animation.Play();
            enabled = false;
            Destroy(selfCollider.gameObject);
        }
    }
}
