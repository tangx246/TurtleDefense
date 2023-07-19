using TMPro;
using UnityEngine;

public class Player : MonoBehaviour
{
    public LayerMask groundLayer;

    [Header("Pit Trap")]
    public GameObject pitTrapPrefab;
    public int pitTrapCount = 1;
    public TMP_Text pitTrapText;

    [SerializeField] private GameObject trapOnCursor = null;
    [SerializeField] private Trap currentTrapType = Trap.None;

    private void Start()
    {
        UpdateUI();
    }

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
        if (pitTrapCount > 0)
        {
            trapOnCursor = Instantiate(pitTrapPrefab);
            currentTrapType = Trap.Pit;
        }
    }

    public void PlaceCurrentTrap()
    {
        if (currentTrapType != Trap.None)
        {
            Debug.Log("Placing trap");
            switch (currentTrapType)
            {
                case Trap.Pit:
                    pitTrapCount--;
                    break;
            }
            var trap = Instantiate(pitTrapPrefab, trapOnCursor.transform.position, trapOnCursor.transform.rotation);
            ActivateTrap(trap);
            Destroy(trapOnCursor);
            trapOnCursor = null;
            UpdateUI();
        }
    }

    private void ActivateTrap(GameObject go)
    {
        go.GetComponentInChildren<TurtleDestroyer>().enabled = true;
        currentTrapType = Trap.None;
    }

    private void UpdateUI()
    {
        pitTrapText.text = pitTrapCount.ToString();
    }

    private enum Trap 
    { 
        None,
        Pit
    }
}
