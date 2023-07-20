using System;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public int turtlesAlive = 0;
    public GameObject canvas;
    public GameObject victoryScreen;
    public GameObject failureScreen;

    private void Start()
    {
        // Find all turtles
        var turtles = FindObjectsByType<Egg>(FindObjectsSortMode.None);
        turtlesAlive = turtles.Length;
    }

    public void TurtleEscaped()
    {
        // Instant loss
        canvas.SetActive(true);
        failureScreen.SetActive(true);
    }

    public void TurtleDestroyed()
    {
        if (failureScreen.activeSelf)
        {
            return;
        }

        turtlesAlive--;
        if (turtlesAlive <= 0)
        {
            // Instant win
            canvas.SetActive(true);
            victoryScreen.SetActive(true);
        }
    }

    public void RepeatStage()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }

    public void NextStage()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }
}
