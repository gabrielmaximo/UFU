package screen

import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import component.ButtonsComponent

class LibraryItemScreen(private val itemName: String) {
    @Composable
    fun build() {
        var title by remember { mutableStateOf("") }
        var year by remember { mutableStateOf("") }

        TextField(
            value = title,
            onValueChange = { title = it },
            label = { Text("title") }
        )
        TextField(
            value = year,
            onValueChange = { year = it },
            label = { Text("year") }
        )
        when (this.itemName) {
            "Book" -> {
                bookComponents(title, year)
            }
            "Magazine" -> {
                magazineComponents(title, year)
            }
        }
    }

    @Composable
    private fun bookComponents(title: String, year: String) {
        var author by remember { mutableStateOf("") }
        TextField(
            value = author,
            onValueChange = { author = it },
            label = { Text("author") }
        )
        ButtonsComponent(title = title, author = author, year = year, itemName = this.itemName).build()
    }

    @Composable
    private fun magazineComponents(title: String, year: String) {
        var org by remember { mutableStateOf("") }
        var number by remember { mutableStateOf("") }
        var vol by remember { mutableStateOf("") }

        TextField(
            value = org,
            onValueChange = { org = it },
            label = { Text("org") }
        )
        TextField(
            value = number,
            onValueChange = { number = it },
            label = { Text("nro") }
        )
        TextField(
            value = vol,
            onValueChange = { vol = it },
            label = { Text("vol") }
        )
        ButtonsComponent(
            title = title,
            org = org,
            number = number,
            vol = vol,
            year = year,
            itemName = this.itemName
        ).build()
    }
}