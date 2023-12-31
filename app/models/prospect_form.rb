class ProspectForm < ApplicationRecord
  has_one :proposition
  has_many :etablissements, through: :propositions

validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Veuillez entrer une adresse email valide" }, uniqueness: true
validates :telephone, presence: true, format: { with: /\A[0-9]{10}\z/, message: "Veuillez entrer un numéro de téléphone valide" }, uniqueness: true
validates :adresse_de_recherche, presence: true


geocoded_by :adresse_de_recherche, latitude: :latitude_de_recherche, longitude: :longitude_de_recherche
after_validation :geocode

# Avant la sauvegarde du modèle, appelez la méthode de parsing

end
