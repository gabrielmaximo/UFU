package dto

data class Book(
    override val title: String,
    override val year: Int,
    val author: String
): LibraryItem(title, year)