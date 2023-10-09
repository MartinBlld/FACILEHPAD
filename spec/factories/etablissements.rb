FactoryBot.define do
  factory :etablissement do
    finesset {'130798754'}
    siret { '12345678901234' }
    raison_sociale { 'Test Etablissement' }
    adresse { '123 rue de la Test, 75000 Paris' }
    telephone { '0123456789' }
    date_maj { '2023-10-01' }
    latitude { 48.8566 }
    longitude { 2.3522 }
    status { 'Active' }
  end
end
