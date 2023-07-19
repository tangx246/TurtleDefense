using UnityEngine;

public class Player : MonoBehaviour
{
    public LayerMask groundLayer;

    public GameObject pitTrapPrefab;

    public GameObject trapOnCursor = null;

    private void Update()
    {
        var mousePos = Input.mousePosition;
        // Raycast towards the ground based on mouse position
        var ray = Camera.main.ScreenPointToRay(mousePos);
        if (Physics.Raycast(ray, out var hitInfo, 1000f, groundLayer))
        {
            var hitPoint = hitInfo.point;
            if (trapOnCursor != null)
            {
                trapOnCursor.transform.position = hitPoint;
            }
        }
    }

    public void StartPlacingPitTrap()
    {
        trapOnCursor = Instantiate(pitTrapPrefab);
    }

    public void PlaceCurrentTrap()
    {
        Debug.Log("Placing trap");
        var trap = Instantiate(pitTrapPrefab, trapOnCursor.transform.position, trapOnCursor.transform.rotation);
        ActivateTrap(trap);
        Destroy(trapOnCursor);
        trapOnCursor = null;
    }

    private void ActivateTrap(GameObject go)
    {
        go.GetComponentInChildren<TurtleDestroyer>().enabled = true;
    }
}
