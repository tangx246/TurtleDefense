using UnityEngine;
using UnityEngine.AI;

public class OilSpill : MonoBehaviour
{
    public float slowFactor = 2f;

    private void OnTriggerEnter(Collider other)
    {
        if (!enabled)
        {
            return;
        }

        var navMeshAgent = other.GetComponentInParent<NavMeshAgent>();
        navMeshAgent.speed /= slowFactor;
    }

    private void OnTriggerExit(Collider other)
    {
        var navMeshAgent = other.GetComponentInParent<NavMeshAgent>();
        navMeshAgent.speed *= slowFactor;
    }
}
