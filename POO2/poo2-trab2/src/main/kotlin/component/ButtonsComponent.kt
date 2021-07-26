package component

import androidx.compose.desktop.AppWindow
import androidx.compose.desktop.Window
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.IntSize
import dto.Book
import dto.LibraryItem
import dto.Magazine

class ButtonsComponent(
    private val title: String,
    private val author: String? = null,
    private val org: String? = null,
    private val number: String? = null,
    private val vol: String? = null,
    private val year: String,
    private val itemName: String
) {
    companion object {
        val libraryItems = mutableListOf<LibraryItem>()
    }

    @Composable
    fun build() {
        addButton(libraryItems)
        listButton(libraryItems)
    }

    @Composable
    private fun listButton(libraryItems: MutableList<LibraryItem>) {
        Button(onClick = {
            Window("Listing Books", size = IntSize(800, 600)) {
                ScrollListComponent.lazyScrollable(libraryItems)
            }
        }) {
            Text("list")
        }
    }

    @Composable
    private fun addButton(libraryItems: MutableList<LibraryItem>) {
        return Button(onClick = {
            try {
                if (title.isBlank() || year.isBlank())
                    throw Exception()

                var item: LibraryItem? = null

                when (this.itemName) {
                    "Book" -> {
                        if(author.isNullOrBlank())
                            throw Exception()
                        item = Book(title, year.toInt(), author)
                    }
                    "Magazine" -> {
                        if(
                            org.isNullOrBlank() ||
                            number.isNullOrBlank() ||
                            vol.isNullOrBlank()
                        ) throw Exception()
                        item = Magazine(title, year.toInt(), org, vol.toInt(), number.toInt())
                    }
                }

                libraryItems.add(item!!)

                AppWindow("Success", size = IntSize(250, 250)).show {
                    Text("Item added")
                }
            } catch (err: Exception) {
                AppWindow("Failure", size = IntSize(250, 250)).show {
                    Text("Invalid fields!")
                }
            }
        }) {
            Text("add")
        }
    }
}