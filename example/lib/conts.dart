const magicList = [
  MagicAnimateGroup(
      title: 'MAGIC EFFECTS',
      animates: ['MAGIC', 'TWISTERINDOWN', 'TWISTERINUP', 'SWAP']),
  MagicAnimateGroup(
      title: 'BLING', animates: ['PUFFIN', 'PUFFOUT', 'VANISHIN', 'VANISHOUT']),
  MagicAnimateGroup(title: 'STATIC EFFECTS', animates: [
    'OPENDOWNLEFT',
    'OPENDOWNRIGHT',
    'OPENUPLEFT',
    'OPENUPRIGHT',
    'OPENDOWNLEFTRETURN',
    'OPENDOWNRIGHTRETURN',
    'OPENUPLEFTRETURN',
    'OPENUPRIGHTRETURN',
  ]),
  MagicAnimateGroup(title: 'STATIC EFFECTS OUT', animates: [
    'OPENDOWNLEFTOUT',
    'OPENDOWNRIGHTOUT',
    'OPENUPLEFTOUT',
    'OPENUPRIGHTOUT',
  ]),
  MagicAnimateGroup(title: 'PERSPECTIVE', animates: [
    'PERSPECTIVEDOWN',
    'PERSPECTIVEUP',
    'PERSPECTIVELEFT',
    'PERSPECTIVERIGHT',
    'PERSPECTIVEDOWNRETURN',
    'PERSPECTIVEUPRETURN',
    'PERSPECTIVELEFTRETURN',
    'PERSPECTIVERIGHTRETURN'
  ]),
  MagicAnimateGroup(
      title: 'ROTATE',
      animates: ['ROTATEDOWN', 'ROTATEUP', 'ROTATELEFT', 'ROTATERIGHT']),
  MagicAnimateGroup(title: 'SLIDE', animates: [
    'SLIDEDOWN',
    'SLIDEUP',
    'SLIDELEFT',
    'SLIDERIGHT',
    'SLIDEDOWNRETURN',
    'SLIDEUPRETURN',
    'SLIDELEFTRETURN',
    'SLIDERIGHTRETURN'
  ]),
  MagicAnimateGroup(
      title: 'MATH', animates: ['SWASHOUT', 'SWASHIN', 'FOOLISHIN', 'HOLEOUT']),
  MagicAnimateGroup(title: 'TIN', animates: [
    'TINRIGHTOUT',
    'TINLEFTOUT',
    'TINUPOUT',
    'TINDOWNOUT',
    'TINRIGHTIN',
    'TINLEFTIN',
    'TINUPIN',
    'TINDOWNIN'
  ]),
  MagicAnimateGroup(title: 'BOMB', animates: ['BOMBRIGHTOUT', 'BOMBLEFTOUT']),
  MagicAnimateGroup(title: 'BOING', animates: ['BOINGINUP', 'BOINGOUTDOWN']),
  MagicAnimateGroup(title: 'ON THE SPACE', animates: [
    'SPACEOUTUP',
    'SPACEOUTRIGHT',
    'SPACEOUTDOWN',
    'SPACEOUTLEFT',
    'SPACEINUP',
    'SPACEINRIGHT',
    'SPACEINDOWN',
    'SPACEINLEFT'
  ])
];

class MagicAnimateGroup {
  final String title;
  final List<String> animates;
  const MagicAnimateGroup({required this.title, required this.animates});
}
