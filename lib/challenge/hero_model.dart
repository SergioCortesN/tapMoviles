

class HeroModel {
  final String name;
  final String image;
  final double speed, health, attack;
  final String Descp;

  HeroModel({
    required this.name,
    required this.image,
    required this.speed,
    required this.health,
    required this.attack,
    required this.Descp,
  });
}

final List<HeroModel> heroes = [
  HeroModel(
    name: 'MOLTRES (GALAR)',
    image: 'challenge/moltres.png',
    speed: 45.0,
    health: 45.0,
    attack: 92.5,
    Descp: 'Su aura maligna con aspecto de llama ardiente puede calcinar el alma de quien la toca.'
  ),
  HeroModel(
    name: 'ENTEI',
    image: 'challenge/entei.png',
    speed: 45.0,
    health: 57.5,
    attack: 96.0,
    Descp: 'Entei contiene el fulgor del magma en su interior. Se cree que este Pokémon nació de la erupción de un volcán. Escupe numerosas ráfagas de fuego que devoran y reducen a cenizas todo lo que tocan.'
  ),
  HeroModel(
    name: 'incineroar',
    image: 'challenge/incineroar.png',
    speed: 30.0,
    health: 47.5,
    attack: 92.6,
    Descp: 'Cuando se aviva su espíritu combativo, las llamas que le rodean la cintura también arden de forma especialmente intensa.'

  ),
];
