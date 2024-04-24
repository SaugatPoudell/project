class CatalogueModel
{
  

static final items = [
  Item(
    id: 1,
    name: "Iphone12",
    desc: "This a a apple Iphone 12",
    price: 999,
    color: "red",
    image:
        "https://pokharamobilestore.com/wp-content/uploads/2023/04/Iphone-12-Black-1-1.jpg",
  )
];

}
class Item {
  final num id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.color,
    required this.image,
  });
}

