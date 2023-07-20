using DG.Tweening;
using System.Collections;
using System.Threading.Tasks;
using UnityEngine;

public class StrawTower : MonoBehaviour
{
    public float shootRate = 1f;
    public float radius = 3f;
    public float projectileSpeed = 5f;
    public GameObject projectile;
    public LayerMask turtleMask;
    public GameObject aimer;

    private void Start()
    {
        //InvokeRepeating("Shoot", shootRate, shootRate);
        StartCoroutine(ShootCoroutine());
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
                tween?.Kill();
                Destroy(bullet?.gameObject);
                Destroy(turtle?.gameObject);
            }
        }
    }
}
