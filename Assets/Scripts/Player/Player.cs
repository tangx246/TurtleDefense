using TMPro;
using UnityEngine;

public class Player : MonoBehaviour
{
    public LayerMask groundLayer;

    [Header("Pit Trap")]
    public GameObject pitTrapPrefab;
    public int pitTrapCount = 1;
    public TMP_Text pitTrapText;

    [Header("Pushbox")]
    public GameObject pushboxPrefab;
    public int pushboxCount = 0;
    public TMP_Text pushboxText;

    [Header("Tower")]
    public GameObject towerPrefab;
    public int towerCount = 0;
    public TMP_Text towerText;

    [Header("Debug")]
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

    public void StartPlacingTower()
    {
        StartPlacingThing(ref towerCount, towerPrefab, Trap.Tower);
    }

    public void StartPlacingPushbox()
    {
        StartPlacingThing(ref pushboxCount, pushboxPrefab, Trap.Pushbox);
    }

    public void StartPlacingPitTrap()
    {
        StartPlacingThing(ref pitTrapCount, pitTrapPrefab, Trap.Pit);
    }

    private void StartPlacingThing(ref int trapCount, GameObject trapPrefab, Trap trapType)
    {
        if (trapCount > 0)
        {
            trapOnCursor = Instantiate(trapPrefab);
            currentTrapType = trapType;
        }
    }

    public void PlaceCurrentTrap()
    {
        if (currentTrapType != Trap.None)
        {
            Debug.Log("Placing trap");
            GameObject prefab;
            switch (currentTrapType)
            {
                case Trap.Pit:
                    pitTrapCount--;
                    prefab = pitTrapPrefab;
                    break;
                case Trap.Pushbox:
                    pushboxCount--;
                    prefab = pushboxPrefab;
                    break;
                case Trap.Tower:
                    towerCount--;
                    prefab = towerPrefab;
                    break;
                default:
                    Debug.LogError("Unhandled trap type");
                    return;
            }
            var trap = Instantiate(prefab, trapOnCursor.transform.position, trapOnCursor.transform.rotation);
            ActivateTrap(trap);
            Destroy(trapOnCursor);
            trapOnCursor = null;
            UpdateUI();
        }
    }

    private void ActivateTrap(GameObject go)
    {
        var turtleDestroyer = go.GetComponentInChildren<TurtleDestroyer>();
        if (turtleDestroyer != null)
            turtleDestroyer.enabled = true;

        var pushbox = go.GetComponentInChildren<Pushbox>();
        if (pushbox != null)
            pushbox.enabled = true;

        var tower = go.GetComponentInChildren<StrawTower>();
        if (tower != null)
            tower.enabled = true;

        currentTrapType = Trap.None;
    }

    private void UpdateUI()
    {
        pitTrapText.text = pitTrapCount.ToString();
        pushboxText.text = pushboxCount.ToString();
        towerText.text = towerCount.ToString();
    }

    private enum Trap 
    { 
        None,
        Pit,
        Pushbox,
        Tower
    }
}
