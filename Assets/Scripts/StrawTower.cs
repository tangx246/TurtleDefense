using DG.Tweening;
using System.Collections;
using UnityEngine;

public class StrawTower : MonoBehaviour
{
    public float shootRate = 1f;
    public float radius = 3f;
    public float projectileSpeed = 5f;
    public GameObject projectile;
    public LayerMask turtleMask;
    public GameObject aimer;
    public GameObject rangeGuide;

    private void Awake()
    {
        rangeGuide.transform.localScale = new Vector3(radius*2, radius*2, radius*2);
    }

    private void Start()
    {
        StartCoroutine(ShootCoroutine());
        Destroy(rangeGuide);
    }

    private IEnumerator ShootCoroutine()
    {
        while (true)
        {
            yield return new WaitForSeconds(shootRate);

            var turtles = Physics.OverlapSphere(transform.position, radius, turtleMask);

            if (turtles.Length > 0)
            {
                var turtle = turtles[0].GetComponentInParent<Turtle>(true);
                var distanceToTurtle = Vector3.Distance(aimer.transform.position, turtle.transform.position);
                var timeToTurtle = distanceToTurtle / projectileSpeed;
                aimer.transform.LookAt(turtle.transform.position);

                var bullet = Instantiate(projectile, aimer.transform.position, aimer.transform.rotation);
                var tween = bullet.transform.DOMove(turtle.transform.position, timeToTurtle);

                yield return new WaitForSeconds(timeToTurtle);
                if (tween != null)
                    tween.Kill();
                if (bullet != null) 
                    Destroy(bullet.gameObject);
                if (turtle != null)
                    Destroy(turtle.gameObject);
            }
        }
    }
}
