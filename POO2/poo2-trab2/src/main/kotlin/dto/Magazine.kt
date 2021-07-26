package dto

data class Magazine(
    override val title: String,
    override val year: Int,
    val org: String,
    val number: Int,
    val vol: Int
): LibraryItem(title, year)