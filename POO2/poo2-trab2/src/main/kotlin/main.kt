import androidx.compose.desktop.Window
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.IntSize
import androidx.compose.ui.unit.dp
import screen.LibraryItemScreen

fun main() = Window("Library Management", IntSize(1366, 720)) {
    var currentItem by remember { mutableStateOf("Book") }
    var nextItem by remember { mutableStateOf("Magazine") }

    MaterialTheme {
        Column(Modifier.fillMaxSize(), Arrangement.spacedBy(5.dp)) {
            Text(currentItem)
            LibraryItemScreen(currentItem).build()
            Button(onClick = {
                val previousItem = currentItem
                currentItem = nextItem
                nextItem = previousItem
            }) {
                Text(nextItem)
            }
        }
    }
}