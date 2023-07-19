using UnityEngine;
using UnityEngine.AI;

public class Turtle : MonoBehaviour
{
    public NavMeshAgent agent;

    private void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
    }

    void Start()
    {
        // Search for all TurtleEscapers, and then path towards them
        TurtleDestroyer[] turtleEscapers = FindObjectsByType<TurtleDestroyer>(FindObjectsSortMode.None);

        // If there are no TurtleEscapers, then log an error and return
        if (turtleEscapers.Length == 0)
        {
            Debug.LogError("No TurtleEscapers found!");
            return;
        }

        // Find the closest point to the closest TurtleEscaper
        Vector3 closestPoint = transform.position;
        float closestDistance = Mathf.Infinity;
        foreach (TurtleDestroyer turtleEscaper in turtleEscapers)
        {
            if (!turtleEscaper.isActiveAndEnabled || turtleEscaper.isTrap)
            {
                continue;
            }

            var collider = turtleEscaper.GetComponentInChildren<Collider>();
            var point = collider.ClosestPoint(transform.position);
            float distance = Vector3.Distance(transform.position, point);
            if (distance < closestDistance)
            {
                closestPoint = point;
                closestDistance = distance;
            }
        }

        // Push closestPoint into the destination a bit
        closestPoint += (closestPoint - transform.position).normalized * 0.5f;

        // Set the destination to the closest point
        agent.SetDestination(closestPoint);
        Debug.DrawLine(transform.position, closestPoint, Color.red, 3f);
    }
}
