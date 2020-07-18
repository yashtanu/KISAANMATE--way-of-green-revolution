class ResultMapper {
  dynamic confidence;
  dynamic index;
  dynamic label;

ResultMapper(this.confidence, this.index, this.label);

  ResultMapper.fromJson(Map<String, dynamic> json) {
    confidence = json['confidence'];
    index = json['index'];
    label = json['label'];
  }

  Map<String, dynamic> toMap() => {
    'confidence': confidence,
    'index': index,
    'label': label
  };
}


class PlantsDataMapper {
  String id;
  String name;
  String symptoms;
  String cause;
  String comments;
  String management;

PlantsDataMapper(this.id, this.name, this.symptoms, this.cause, this.comments, this.management);

  PlantsDataMapper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symptoms = json['symptoms'];
    cause = json['cause'];
    comments = json['comments'];
    management = json['management'];
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'symptoms': symptoms,
    'cause': cause,
    'comments': comments,
    'management': management
  };
}

final List plantsList = [
  {
    'id': 'Apple___Cedar_apple_rust',
    'name': 'Apple',
    'symptoms': 'Bright orange or yellow patches on top side of leaves surrounded by a red band and small black spots in the center; by mid-summer, cup-like structures called aecia form on the leaf undersides; these become covered in tubular structures from which spores are released',
    'cause': 'Fungus',
    'comments': 'Fungus requires two hosts to complete lifecycle; forms galls on Eastern red cedar and spores are carried by wind to apple; use caution when planting apple close to red cedar.',
    'management': 'Plant resistant varieties where possible; remove nearby red cedar; if growing susceptible varieties in proximity to red cedar follow a fungicide program.'
  },
  {
    'id': 'Peach___Bacterial_spot',
    'name': 'Peach',
    'symptoms': 'Water soaked, angular gray lesions on the underside of the leaves which turn purple and necrotic in the center and cause a shot hole appearance if lesion center drops out; if lesions are present in high numbers on leaves they may become chlorotic and drop from tree; cankers develop on twigs either as raised blisters or as a dark area surrounding a bud that fails to open; in years of severe infection the entire fruit crop may be lost; lesions on fruit begin as small brown, water-soaked lesions which may exude gum',
    'cause': 'Bacterium',
    'comments': 'Periods of frequent rainfall during late bloom and early petal drop increase likelihood of fruit and leaf infection; infection is rare during hot, dry weather',
    'management': 'Avoid planting susceptible peach varieties in areas where disease is known; once disease is visible it can be difficult to control, protective copper applications in the Fall prior to leaf drop and/or application in early growing season may help prevent the disease; care should be taken as peach trees are very sensitive to copper'
  },
  {
    'id': 'Grape___healthy',
    'name': 'Grape',
    'symptoms': 'None',
    'cause': 'None',
    'comments': 'None',
    'management': 'None'
  },
  {
    'id': 'Tomato___Early_blight',
    'name': 'Tomato',
    'symptoms': 'Early blight symptoms start as oval shaped lesions with a yellow chlorotic region across the lesion; concentric leaf lesions may be seen on infected leaves; leaf tissue between veins is destroyed; severe infections can cause leaves to completely collapse; as the disease progresses leaves become severely blighted leading to reduced yield; tomato stems may become infected with the fungus leading to Alternaria stem canker; initial symptoms of of stem canker are the development of dark brown regions on the stem; stem cankers may enlarge to girdle the whole stem resulting in the death of the whole plant; brown streaks can be found in the vascular tissue above and below the canker region; fruit symptoms include small black v-shaped lesions at the shoulders of the fruit (the disease is also known black shoulder); lesions may also appear on the fruit as dark flecks with concentric ring pattern; fruit lesions can seen in the field or may develop during fruit transit to the market; the lesions may have a velvety appearance caused by sporulation of the fungus.',
    'cause': 'Fungus',
    'comments': 'Disease can spread rapidly after plants have set fruit; movement of air-borne spores and contact with infested soil are causes for the spread of the disease',
    'management': 'Apply appropriate fungicide at first sign of disease; destroy any volunteer solanaceous plants (tomato, potato, nightshade etc); practice crop rotation'
  },
  {
    'id': 'Tomato___Late_blight',
    'name': 'Tomato',
    'symptoms': 'Late blight affects all aerial parts of the tomato plant; initial symptoms of the disease appear as water-soaked green to black areas on leaves which rapidly change to brown lesions; fluffy white fungal growth may appear on infected areas and leaf undersides during wet weather; as the disease progresses, foliage becomes becomes shriveled and brown and the entire plant may die; fruit lesions start as irregularly shaped water soaked regions and change to greasy spots; entire fruit may become infected and a white fuzzy growth may appear during wet weather.',
    'cause': 'Oomycete',
    'comments': 'Can devastate tomato plantings.',
    'management': 'Plant resistant varieties; if signs of disease are present or if rainy conditions are likely or if using overhead irrigation appropriate fungicides should be applied.'
  },
  {
    'id': 'Tomato___Bacterial_spot',
    'name': 'Tomato',
    'symptoms': 'Bacterial spot lesions starts out as small water-soaked spots; lesions become more numerous and coalesce to form necrotic areas on the leaves giving them a blighted appearance; of leaves drop from the plant severe defoliation can occur leaving the fruit susceptible to sunscald; mature spots have a greasy appearance and may appear transparent when held up to light; centers of lesions dry up and fall out of the leaf; blighted leaves often remain attached to the plant and give it a blighted appearance; fruit infections start as a slightly raised blister; lesions may have a faint halo which eventually disappears; lesions on fruit may have a raised margin and sunken center which gives the fruit a scabby appearance.',
    'cause': 'Bacterium',
    'comments': 'Bacteria survive on crop debris; disease emergence favored by warm temperatures and wet weather; symptoms are very similar to other tomato diseases but only bacterial spot will cause a cut leaf to ooze bacterial exudate; the disease is spread by infected seed, wind-driven rain, diseased transplants, or infested soil; bacteria enter the plant through any natural openings on the leaves or any openings caused by injury to the leaves.',
    'management': 'Use only certified seed and healthy transplants; remove all crop debris from planting area; do not use sprinkler irrigation, instead water from base of plant; rotate crops.'
  },
  {
    'id': 'Potato___Late_blight',
    'name': 'Potate',
    'symptoms': 'Irregularly shaped spreading brown lesions on leaves with distinctive white fluffy sporulation at lesion margins on the underside of the leaf in wet conditions. In dry condition the lesions dry up and go dark brown with collapsed tissue; water-soaked dark green to brown lesions on stems also with characteristic white sporulation; later in infection leaves and petioles completely rotted; severely affected plants may have an slightly sweet distinctive odor; red-brown firm lesions on tubers extending several centimeters into tissue; lesions may be slightly sunken in appearance and often lead to secondary bacterial rots.',
    'cause': 'Oomycete',
    'comments': 'The pathogen can survive for several months to years in the soil; emergence of disease favored by moist, cool conditions; major cause of disease spread is infected tubers',
    'management': 'Control depends on a multifaceted approach with importance of certain practices changing based on geographic location: destroy infected tubers; destroy any volunteer plants; application of appropriate fungicide to potato hills at emergence; time watering to reduce periods of leaf wetness e.g. water early to allow plant to dry off during the day; plant resistant varieties; apply appropriate protective fungicide if disease is forecast in area'
  },
];