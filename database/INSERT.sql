INSERT INTO "public"."brand"("id","name")
VALUES
(E'13328acb-1504-4eb4-bdf0-08176ff39a8e',E'Mercedes-Benz'),
(E'1ad385ce-5d45-4a62-a0a1-586d51b9ae9a',E'Fiat'),
(E'1f4e22c2-7f37-4c4a-8463-8fe446bd345d',E'Kia'),
(E'2693650d-aae7-4fec-a5d9-9019918444b1',E'Audi'),
(E'32c703ae-5f73-4cb5-a850-889f5f4b9d9c',E'Jaguar'),
(E'3bd061a4-4b6b-466b-9d09-11b99c137504',E'Opel'),
(E'42452bf2-af86-42ad-a0fd-24766134bea0',E'Skoda'),
(E'4db8e854-3bea-44a1-aa1a-4719e433d021',E'Mini'),
(E'4ec318ac-3f55-4743-9d93-56755092b067',E'Lucid'),
(E'50874bf4-0066-48c0-ad56-2d8d9c7d9b75',E'XPeng'),
(E'556175a7-fce2-419d-9494-59392dd10143',E'Peugeot'),
(E'629afd85-bbad-4533-b90b-02f20d5aa168',E'Citroën'),
(E'69b386df-ab40-4433-b200-6b4234273900',E'Porsche'),
(E'7073d5e6-f886-4b6a-858d-b1f01ddd6d33',E'BMW'),
(E'7b99fe68-ea13-4a50-b17c-4be9cb409137',E'NIO'),
(E'84c789d5-b2fd-47ab-8d7a-0a77bb672c65',E'Karma'),
(E'85f08b08-dfaa-47a0-95d0-4a774766163c',E'Nissan'),
(E'a759ac58-ac23-4566-81c6-10d6c14573ae',E'Honda'),
(E'a7efe512-121b-4f86-8c64-86f982e238d9',E'MG Motor'),
(E'ad8dc659-4949-43d6-a929-77b4d9a33bc6',E'Hyundai'),
(E'bcfe5026-2cc0-47dc-858d-9d383dc94c5b',E'Volvo'),
(E'c810fabb-9722-4d43-a3a4-0550dae5d454',E'Tesla'),
(E'caa44bc6-59f9-42b7-85a4-c07a066adf56',E'Polestar'),
(E'd4ab9982-51d0-4c93-aad2-9638fb3102b7',E'Ford'),
(E'dee62e50-dc19-4ffc-8de6-1871de5226ec',E'Rimac'),
(E'ebee5791-b05e-4019-a446-6511541ba57d',E'Volkswagen');

INSERT INTO "public"."car"("id","model","brand_id","image_url","start_day_price_euro_excl_vat","seats","doors","year","horsepower","wltp_range_km","battery_capacity_kwh")
VALUES
(E'0c6bc3f6-4727-48c4-b786-1bbcf048c5a0',E'EQC 400 4MATIC',E'13328acb-1504-4eb4-bdf0-08176ff39a8e',E'assets/images/cars/MercedesBenzEQC.png',77,5,5,2019,408,411,85),
(E'a4b009c3-5262-4a3f-aae4-fd7e087a47f1',E'EQB 300 4MATIC',E'13328acb-1504-4eb4-bdf0-08176ff39a8e',E'assets/images/cars/MercedesBenzEQB.png',70,5,5,2021,228,419,79.8),
(E'b8847488-7468-4e7e-ae02-065a776f8ad4',E'EQA 250',E'13328acb-1504-4eb4-bdf0-08176ff39a8e',E'assets/images/cars/MercedesBenzEQA.png',65,5,5,2021,190,426,79.8),
(E'c4e937e3-252a-4b69-b671-e2b4135eb633',E'500e',E'1ad385ce-5d45-4a62-a0a1-586d51b9ae9a',E'assets/images/cars/Fiat500e.png',43,4,3,2021,118,321,42),
(E'acfebe1b-0d01-499d-9550-44ed7a3a4a54',E'EV6 Long Range 2WD',E'1f4e22c2-7f37-4c4a-8463-8fe446bd345d',E'assets/images/cars/KiaEV6.png',54,5,5,2021,228,528,82.5),
(E'21934c0c-dcb7-4763-8b76-358b9e63ced2',E'Q4 Sportback e-tron 40',E'2693650d-aae7-4fec-a5d9-9019918444b1',E'assets/images/cars/AudiQ4SB.png',57,5,5,2021,204,534,82),
(E'8bafaf67-985c-475a-8512-afbb284bf666',E'E-tron 50 quattro',E'2693650d-aae7-4fec-a5d9-9019918444b1',E'assets/images/cars/AudiE-tron.png',75,5,5,2018,313,341,71),
(E'91ef163b-7ef0-43ac-9421-a0c6d8116dda',E'Q4 e-tron 40',E'2693650d-aae7-4fec-a5d9-9019918444b1',E'assets/images/cars/AudiQ4.png',55,5,5,2021,204,521,82),
(E'a3ddbedb-0afa-48d2-93bf-b89057068447',E'Mokka-e',E'3bd061a4-4b6b-466b-9d09-11b99c137504',E'assets/images/cars/OpelMokka.png',43,5,5,2021,136,338,50),
(E'5d68e8f6-80b4-4fed-8755-ac9149b0c459',E'Enyaq iV 80',E'42452bf2-af86-42ad-a0fd-24766134bea0',E'assets/images/cars/SkodaEnyaq.png',56,5,5,2021,204,534,82),
(E'5c939f04-a00d-4afb-9b12-dbd6e95ba991',E'e-2008 SUV',E'556175a7-fce2-419d-9494-59392dd10143',E'assets/images/cars/Peugeot2008.png',45,5,5,2019,136,342,50),
(E'32231089-31a7-463f-a607-416bc36dcfbe',E'e-C4',E'629afd85-bbad-4533-b90b-02f20d5aa168',E'assets/images/cars/CitroenC4.png',41,5,5,2020,136,357,50),
(E'7d31adaa-d6df-401b-b096-46e769e952fc',E'Taycan 4S',E'69b386df-ab40-4433-b200-6b4234273900',E'assets/images/cars/PorscheTaycan.png',111,4,5,2019,530,408,79.2),
(E'08554940-0257-47e7-93ca-de5d847307d5',E'iX3',E'7073d5e6-f886-4b6a-858d-b1f01ddd6d33',E'assets/images/cars/BMWiX3.png',84,5,5,2020,286,461,80),
(E'418d95b0-a8ca-43d3-b573-75494e09643e',E'iX xDrive40',E'7073d5e6-f886-4b6a-858d-b1f01ddd6d33',E'assets/images/cars/BMWiX.png',101,7,5,2021,326,425,76.6),
(E'd94ef8a7-6968-4fcd-8553-53768f6d8d7e',E'i4 eDrive40',E'7073d5e6-f886-4b6a-858d-b1f01ddd6d33',E'assets/images/cars/BMWi4.png',76,5,5,2021,340,590,83.9),
(E'8dc9e31b-323b-4597-996f-f1061527e021',E'IONIQ 5 Long Range 2WD',E'ad8dc659-4949-43d6-a929-77b4d9a33bc6',E'assets/images/cars/HyundaiIoniq5.png',57,5,5,2021,218,485,77.4),
(E'2f0321e9-971f-4985-ad91-bda52c420320',E'C40 Recharge',E'bcfe5026-2cc0-47dc-858d-9d383dc94c5b',E'assets/images/cars/VolvoC40.png',58,5,5,2021,408,420,78),
(E'fd964a2d-a7c3-4526-8555-be2b21613d34',E'XC40 Recharge Pure Electric',E'bcfe5026-2cc0-47dc-858d-9d383dc94c5b',E'assets/images/cars/VolvoXC40.png',58,5,5,2021,231,425,70),
(E'4b382726-4733-4ad2-b2f6-2acc68fba4b0',E'Model 3',E'c810fabb-9722-4d43-a3a4-0550dae5d454',E'assets/images/cars/TeslaModel3.png',66,5,5,2021,325,495,60),
(E'71b56b9f-1784-4c1b-ba9c-e66336b83512',E'Model Y Long Range Dual Motor',E'c810fabb-9722-4d43-a3a4-0550dae5d454',E'assets/images/cars/TeslaModelY.png',74,5,5,2021,441,507,75),
(E'cea78627-d6ea-4a6c-b419-dcc7a3b64d9f',E'Model S Plaid',E'c810fabb-9722-4d43-a3a4-0550dae5d454',E'assets/images/cars/TeslaModelS.png',142,5,5,2021,1033,628,100),
(E'3d09516b-f340-4707-81ae-045fc199f4c7',E'2 Long Range Single Motor',E'caa44bc6-59f9-42b7-85a4-c07a066adf56',E'assets/images/cars/Polestar2.png',60,5,5,2019,231,540,78),
(E'0b9125ef-22ce-429e-b576-f2daac0d0008',E'Mustang Mach-E ER RWD',E'd4ab9982-51d0-4c93-aad2-9638fb3102b7',E'assets/images/cars/FordMustangMachE.png',64,5,5,2020,294,610,98.7),
(E'c0736218-d84d-4b67-ac32-04a671387719',E'ID.4 Pure',E'ebee5791-b05e-4019-a446-6511541ba57d',E'assets/images/cars/VolkswagenID4.png',56,5,5,2020,148,346,55),
(E'ec191651-c0c7-4f28-93c0-fe197be39435',E'ID.3 Pro',E'ebee5791-b05e-4019-a446-6511541ba57d',E'assets/images/cars/VolkswagenID3.png',47,5,5,2020,145,427,62);

INSERT INTO "public"."car_option"("id","name")
VALUES
(E'0af53a43-1cfb-4545-b9a2-eb105dc56820',E'GPS'),
(E'1a5ea3d5-3c62-46a4-94b7-68ce19b6ff97',E'Cruise Control'),
(E'213b2eff-d364-4e6f-acf7-ad08a04c1e13',E'Leather seats'),
(E'2a62ed97-53b9-46c2-8be6-16272b554380',E'Sunroof'),
(E'4277a71b-c2b4-4c97-b5c2-30527ccf1275',E'Bluetooth'),
(E'825b2dfc-9471-4664-8773-b69133eba647',E'Sport pack'),
(E'94755824-7e49-4ede-abc0-cfc3aae912c5',E'Air Conditioning'),
(E'b120887b-6361-44a0-be67-d3c0d6f3f128',E'Adaptive Cruise Control'),
(E'bc394a6c-497c-4ac5-a925-9d01bac63b5b',E'Heated seats'),
(E'e1a143da-97a4-47cc-a1aa-4431e00a678a',E'Apple Carplay/Android Auto'),
(E'ec422547-0ef3-446a-9b2d-7f7221635d46',E'Heated steering wheel');

INSERT INTO "public"."car_car_option"("car_id","car_option_id")
VALUES
(E'4b382726-4733-4ad2-b2f6-2acc68fba4b0',E'0af53a43-1cfb-4545-b9a2-eb105dc56820'),
(E'4b382726-4733-4ad2-b2f6-2acc68fba4b0',E'b120887b-6361-44a0-be67-d3c0d6f3f128'),
(E'cea78627-d6ea-4a6c-b419-dcc7a3b64d9f',E'0af53a43-1cfb-4545-b9a2-eb105dc56820'),
(E'cea78627-d6ea-4a6c-b419-dcc7a3b64d9f',E'b120887b-6361-44a0-be67-d3c0d6f3f128'),
(E'cea78627-d6ea-4a6c-b419-dcc7a3b64d9f',E'bc394a6c-497c-4ac5-a925-9d01bac63b5b'),
(E'cea78627-d6ea-4a6c-b419-dcc7a3b64d9f',E'ec422547-0ef3-446a-9b2d-7f7221635d46'),
(E'cea78627-d6ea-4a6c-b419-dcc7a3b64d9f',E'213b2eff-d364-4e6f-acf7-ad08a04c1e13');

INSERT INTO "public"."country"("id","name")
VALUES
(E'bae52c21-6c6f-498f-8f1c-efc0e46ca978',E'Afghanistan'),
(E'd8fa748b-2d02-43b7-ae90-397880c7821c',E'Afghanistan'),
(E'e5ce2432-5fee-45b9-97c9-a64623798d29',E'Albania'),
(E'67efc55d-e5f2-484a-877b-3e815d20a472',E'Algeria'),
(E'bf2c2720-418a-4650-9721-eade43b69696',E'Andorra'),
(E'a9c2d5b3-b96a-46b1-8078-7dd5db35de82',E'Angola'),
(E'536f9aed-9c9c-4d94-bcbc-45835d8629a1',E'Antigua & Deps'),
(E'1993eb15-d3cf-492a-848d-c6bab0adcc8f',E'Argentina'),
(E'0e3deee6-46fd-4672-8416-d516dd58be2a',E'Armenia'),
(E'4387c736-ab3d-4df7-81c0-63d5d5da4102',E'Australia'),
(E'701a57b5-763b-4f2d-8f4a-baaaf545099f',E'Austria'),
(E'02b0d4f7-f9ff-421b-be35-891823013063',E'Azerbaijan'),
(E'db310ca3-fb41-4360-a954-fd20482a7f15',E'Bahamas'),
(E'f9f38c35-c2c1-49e7-a66f-4042312295c8',E'Bahrain'),
(E'f409a108-5b29-4913-a005-04285aabcd7a',E'Bangladesh'),
(E'95811e8f-9814-4cb0-9be6-2ecffe9184aa',E'Barbados'),
(E'c01ee914-1a77-4841-ab4d-d5b6e0dcc685',E'Belarus'),
(E'c25d9c35-8fa8-41b7-b6fb-c5579897942d',E'Belgium'),
(E'7c36845a-ab50-4270-a75e-928af4a3f6cd',E'Belize'),
(E'c486bcbb-b432-4bf7-8341-bb7dc904b4ea',E'Benin'),
(E'd85c0e06-12fb-45fd-aa25-62216386cbbf',E'Bhutan'),
(E'73090192-8b3c-4b70-ac03-778c30b29f6f',E'Bolivia'),
(E'288feea5-6c1a-472b-a1d2-197eb18aace4',E'Bosnia Herzegovina'),
(E'3cb67be3-bea3-4c67-90cf-4ec5561ee5f3',E'Botswana'),
(E'be9ed444-8339-4cca-b769-091aa0fa8820',E'Brazil'),
(E'2b5cea0b-bf4c-479b-a599-6199c79389b0',E'Brunei'),
(E'aea2b608-bf15-46ba-a318-482d7b4dea7d',E'Bulgaria'),
(E'487fcd5e-67e1-4c76-9c76-191e50c065ed',E'Burkina'),
(E'ad5d7ae5-c09d-4348-b61a-c7f11830ea58',E'Burundi'),
(E'845c33d8-5e9f-4f44-970f-33b49fcab103',E'Cambodia'),
(E'072125a5-fa79-4407-927f-0e2d15539eeb',E'Cameroon'),
(E'e378d39f-10c3-4753-a3bf-9103c9f9fddc',E'Canada'),
(E'4e7d6db8-d98a-4bcd-8a1c-25f52c034fe8',E'Cape Verde'),
(E'934b52e9-d8fc-4e7b-9ce7-c8d17da51e0a',E'Central African Rep'),
(E'9ba56796-862a-442a-8e30-fefe5a50b39e',E'Chad'),
(E'09821677-78e5-487f-9f52-b51903b649b6',E'Chile'),
(E'1f1dbae2-2c17-46af-88e0-694fd78acd39',E'China'),
(E'804bd885-7908-4f63-ab50-1a6619c864bf',E'Colombia'),
(E'abf3ee4b-5e84-4f53-8864-cc3e02100a56',E'Comoros'),
(E'45e88cee-142c-4285-8d20-a4b31e61531f',E'Congo'),
(E'04c0bfa7-415d-4a9b-9951-3b0f21789e28',E'Congo {Democratic Rep}'),
(E'bfebe460-fc0a-40ba-a06d-b07a2eb77381',E'Costa Rica'),
(E'7099ed8e-8fb0-4c9d-acc3-d83a8f6b22cf',E'Croatia'),
(E'ad39365a-1a6a-47f1-815c-c6379dbabc8e',E'Cuba'),
(E'66869d1b-088c-45ff-9403-aa6334fbaedd',E'Cyprus'),
(E'63ad59c8-6f28-4567-8f45-4921e993bef2',E'Czech Republic'),
(E'7c18c580-7083-4f71-8420-980997f291c0',E'Denmark'),
(E'cd0bf283-7f73-4172-8ad5-f0b8f6dde0e8',E'Djibouti'),
(E'5e33f97d-d38c-4296-888c-b03cb74b8f1c',E'Dominica'),
(E'aafd1ba1-69ae-405f-a928-579a74238cdc',E'Dominican Republic'),
(E'5e0a0fec-d07f-46d8-ba17-5da0ff170ef3',E'East Timor'),
(E'fa82bc3c-6a1e-45ef-9a9d-1c8d4fa99a0b',E'Ecuador'),
(E'ff0372fe-6ef2-4fe2-94a3-1d55acd075c9',E'Egypt'),
(E'9a3eeb87-5154-472b-b608-9abd414b0a22',E'El Salvador'),
(E'ff51ef83-a548-485d-81f3-454b0aef4cb7',E'Equatorial Guinea'),
(E'624778f8-48d5-4132-b1a6-0dbe872a7cd6',E'Eritrea'),
(E'87df8c6f-726e-4632-83ec-99af8598b7d2',E'Estonia'),
(E'9bdb0f1a-bcad-4832-b8f2-490833664c0b',E'Ethiopia'),
(E'9a2b7711-3571-4705-9ab1-644bb6ba22e1',E'Fiji'),
(E'2904950c-4c21-4631-84b0-cd56a5444fb4',E'Finland'),
(E'77109387-d87c-4d84-ac2a-7b0f4d2dc3f4',E'France'),
(E'20891cd5-3526-41ad-abd3-a6d3c44453aa',E'Gabon'),
(E'd98e310b-3bdc-4116-aa29-b0a26b38f7a2',E'Gambia'),
(E'53ffaa07-bfbf-4bc2-8797-9a5498f9dd26',E'Georgia'),
(E'aedeb663-eeba-4188-88eb-0e1a735df31d',E'Germany'),
(E'bbd72f52-087a-44b7-83f8-7b47e2af310c',E'Ghana'),
(E'c1b9e10d-c28a-47ca-90bf-7525817a1d0d',E'Greece'),
(E'89f35bac-851a-4cc6-bd70-b165e6b23cb0',E'Grenada'),
(E'7d9e8588-e531-4c3f-b505-4c505c14e962',E'Guatemala'),
(E'819ddffc-6b81-400e-ad4b-89b6a26c6370',E'Guinea'),
(E'e2434612-f945-4e55-959b-19c263dad151',E'Guinea-Bissau'),
(E'530f85ac-4a39-41a9-8a9d-6a3a4a660368',E'Guyana'),
(E'c16f3240-1d2b-460b-be2b-99b81f363f1d',E'Haiti'),
(E'4dc85443-6bf1-4261-86c7-89a3a9292dbd',E'Honduras'),
(E'b633d1bc-22a4-45f5-b7a6-db0800a9c45a',E'Hungary'),
(E'6ca29b54-8e7f-4b6f-a7c0-b83131f9c941',E'Iceland'),
(E'03cec390-10c7-4830-9b58-eeac670c7f44',E'India'),
(E'0af248dd-5d5a-4c25-8271-29d684aef7fd',E'Indonesia'),
(E'9490f3dc-0cef-4bf8-9b1d-ee3263603e37',E'Iran'),
(E'86137a31-febc-4be1-b22b-cc7d39108eb9',E'Iraq'),
(E'25fa81a1-c7c3-404d-a44f-865af51e6558',E'Ireland {Republic}'),
(E'93f0754a-e5c5-4aaf-893a-65b06573ae48',E'Israel'),
(E'36a4e764-03dc-4cf6-822d-4e8f66cbf342',E'Italy'),
(E'47de181d-a5c0-4ed3-8556-2213409ec546',E'Ivory Coast'),
(E'aa39b48f-ec7f-4848-9312-e25c589071aa',E'Jamaica'),
(E'77ea4c6b-9700-4746-9c63-12722db16d86',E'Japan'),
(E'531c7a39-a785-48fb-aa9a-0966f0efb58e',E'Jordan'),
(E'fce7e437-208d-4c21-bd82-a544ebebbf19',E'Kazakhstan'),
(E'd00baf65-bc54-42d4-abb8-15ee4e57377c',E'Kenya'),
(E'688aad31-0190-4d60-bd9e-34759c2c2e22',E'Kiribati'),
(E'8d1427e3-8942-4e41-acbe-a870d388fcdc',E'Korea North'),
(E'369b456e-52b1-4144-aca3-7449bdf72ce2',E'Korea South'),
(E'038c5b41-0ee6-4f39-b27b-e0be6397c1ec',E'Kosovo'),
(E'bcab208b-8d31-4b55-b019-c4041996abe5',E'Kuwait'),
(E'fba0ea5c-6b99-47e5-bed5-772390fc4b02',E'Kyrgyzstan'),
(E'03644271-4fb1-4fff-84ef-d3d069ac0cba',E'Laos'),
(E'ace92663-379e-427e-9edc-4dfaf1d60786',E'Latvia'),
(E'a1014d31-ed0d-40a6-9fed-f7b93b89a624',E'Lebanon'),
(E'b0ee749c-eebf-4d51-b36a-ecd466f94958',E'Lesotho'),
(E'7daa2929-c2c2-4761-ad74-3b2deca68650',E'Liberia'),
(E'95cbf112-637c-45b2-abe1-cab69b3c0898',E'Libya'),
(E'819aee0e-f3cd-4199-b074-ff66beda4ad8',E'Liechtenstein'),
(E'87453963-aaeb-436f-afb2-de68be99bd29',E'Lithuania'),
(E'6fd7fa2b-92d9-43e5-babd-7782c76df2c2',E'Luxembourg'),
(E'ea3762aa-aeb8-4ba7-9209-f649998edb9c',E'Macedonia'),
(E'0ae3637c-94d3-432a-9307-a762472f08ef',E'Madagascar'),
(E'b1816239-60aa-4ae4-bb08-56abd7790d32',E'Malawi'),
(E'4b0ed870-1b49-4baf-b45f-bc3857334e3e',E'Malaysia'),
(E'cc035814-942a-4111-92ec-41cffaff5778',E'Maldives'),
(E'9f4ff845-4896-4b0e-8f30-9f0b8a09a961',E'Mali'),
(E'a871d36f-10e2-43a2-8288-a22672275cc8',E'Malta'),
(E'5ef2cc68-1e3b-4745-b743-38cf4371a5c8',E'Marshall Islands'),
(E'394ef52c-49d8-4f54-b031-80d0263cce90',E'Mauritania'),
(E'39d9a62e-422d-482f-9163-d45fc5ce09d9',E'Mauritius'),
(E'da0b27c8-0819-476b-bf06-0667977b7668',E'Mexico'),
(E'e84f17b3-b7b6-4897-8e8b-13750de07673',E'Micronesia'),
(E'b82ef728-da6d-4740-8f3c-0514a5c47897',E'Moldova'),
(E'6d1c9040-94d5-4194-be2d-98559eba00f4',E'Monaco'),
(E'41ca1282-cc1c-4041-9e94-44fa87fa66aa',E'Mongolia'),
(E'ab765983-b01f-4c76-9e18-8be9411148ce',E'Montenegro'),
(E'3f1f8967-34dd-4aa1-afd4-a1252e389bca',E'Morocco'),
(E'bc1b1541-9dd8-4a0c-9471-6b3a372ff7df',E'Mozambique'),
(E'bdba7886-9caf-4744-bd2b-a5fee1708860',E'Myanmar, {Burma}'),
(E'd22078e7-a45e-4d8e-b4dd-a4d6c9ea6384',E'Namibia'),
(E'c1e30c3a-72b6-4714-8403-33c23c5222b0',E'Nauru'),
(E'4cf7e44d-f927-44af-9f1b-b655cd992335',E'Nepal'),
(E'00d9105e-5577-4b35-883e-2c46fdf083e2',E'Netherlands'),
(E'0b41c038-387c-46e9-889f-054923e87b52',E'New Zealand'),
(E'30fc1992-da49-4bac-98a7-d38218288751',E'Nicaragua'),
(E'dd73b777-800b-4277-8bb2-153683806e61',E'Niger'),
(E'5c186e90-56a5-459d-8572-e3e967bf4c94',E'Nigeria'),
(E'a39f1871-69a4-40d1-aafe-4e3d18ceb12f',E'Norway'),
(E'd8150035-ab7e-4bf2-b535-bc39ad95970b',E'Oman'),
(E'8934fde6-fbc1-4b9a-ac89-76ae73b94000',E'Pakistan'),
(E'7e96efb4-289b-477e-b791-adf1ef41bb93',E'Palau'),
(E'e10dc9ad-1629-4577-8e8a-bee2153d8d5d',E'Panama'),
(E'5d7663ab-2823-4697-b485-cf33236263a7',E'Papua New Guinea'),
(E'a535add1-9a93-437f-8d59-15e1c47a7290',E'Paraguay'),
(E'77079fbf-88ad-43c2-b297-8c8e6d6541a6',E'Peru'),
(E'59f9ae55-aa28-4546-a34d-9f98561bf00f',E'Philippines'),
(E'ff2d1e68-1ece-468a-bb78-09e84ba0440d',E'Poland'),
(E'65e1a6f2-fb43-4851-ba8b-e294bf24a7ab',E'Portugal'),
(E'f1231f5d-f892-442a-828f-cee66cd9d453',E'Qatar'),
(E'567afb53-8041-4240-90b1-975487be8796',E'Romania'),
(E'9f5537b9-a5b4-44e4-b787-492ff25415e3',E'Russian Federation'),
(E'7827b63d-575e-4ea6-ba9b-f8bb3438c5d3',E'Rwanda'),
(E'2c0405a6-af0a-4005-be68-c0a4066dc730',E'Saint Vincent & the Grenadines'),
(E'bfa5c5cf-a82f-4ec0-8f71-1806daf81d32',E'Samoa'),
(E'3d8ff26a-e43e-4f69-9dfb-9e011fd41e36',E'San Marino'),
(E'f35cd3c5-c44c-4c96-81e3-8c5f741102f4',E'Sao Tome & Principe'),
(E'82c2a3db-4f22-487a-a5bf-5f46a387fa44',E'Saudi Arabia'),
(E'8e5bb0c2-f38f-42a1-a2d4-fc14c3f2f8f3',E'Senegal'),
(E'30597c97-d36d-4703-8fda-a0b4fa0b991b',E'Serbia'),
(E'ba02c5fc-5931-46d1-8efe-e9f2d56d4232',E'Seychelles'),
(E'19200eb5-f92f-48d2-a650-36162fd00966',E'Sierra Leone'),
(E'f3145a88-89af-4415-9e05-8e05906754d6',E'Singapore'),
(E'c061e8d5-94e9-4783-9327-6d9fd3cd946a',E'Slovakia'),
(E'8335d3c2-581d-4163-8ce0-56df3d785577',E'Slovenia'),
(E'f841866b-10ec-452d-9071-281fec092f74',E'Solomon Islands'),
(E'9fd9c085-3261-40b8-bb83-078ce83b0b7a',E'Somalia'),
(E'8fe91aa4-2a12-4abc-a389-938adfe18acf',E'South Africa'),
(E'76fd069b-69c5-461c-a49a-fe3cc50ab750',E'South Sudan'),
(E'121783ef-e317-4e1c-a63f-792bcb59e70b',E'Spain'),
(E'b0238438-1083-4592-87f2-aa9599b870ae',E'Sri Lanka'),
(E'45eca93e-df43-4e66-be21-5c49d1beaeca',E'St Kitts & Nevis'),
(E'9a5293bc-f264-4d5d-a0ff-7e36de57dac4',E'St Lucia'),
(E'd1659f5c-8374-4cf8-bac8-d1e0e3c4aa07',E'Sudan'),
(E'f68a8c78-d3f0-41ba-8565-7e096e5a72fa',E'Suriname'),
(E'784f2c19-b142-4995-9532-c291807e5aff',E'Swaziland'),
(E'8cdedfa4-34b7-40b9-a523-b64d6a68e23b',E'Sweden'),
(E'6c88b500-2c69-4a47-8598-e7aa1c513bda',E'Switzerland'),
(E'5b09c68f-eabd-4621-92a8-99a89884d71d',E'Syria'),
(E'beb3ba85-f53a-4d22-bbb9-21298d1759c2',E'Taiwan'),
(E'7d68a2a6-887d-4062-8b9a-9a4f8a3363ae',E'Tajikistan'),
(E'eafa39c1-b114-4334-9087-1d61de186dc8',E'Tanzania'),
(E'9d1a3bef-1c9b-4970-bb2b-f3801dd4575b',E'Thailand'),
(E'6b426fa8-4c5e-401e-ac1d-634c96c408f3',E'Togo'),
(E'74929446-c6b0-43ad-8c36-fc9a87e52199',E'Tonga'),
(E'e0d8a7b3-4995-422d-a93f-17837079a558',E'Trinidad & Tobago'),
(E'd94c0e19-d59e-4546-a37a-5250b24de840',E'Tunisia'),
(E'254de3d6-c438-492e-b7e3-3d2a3cac44b3',E'Turkey'),
(E'62a565b2-4aff-4bb4-be65-bc56f63607cf',E'Turkmenistan'),
(E'1fc0a085-3c61-4192-8b8e-b3a5e7587d8b',E'Tuvalu'),
(E'f90ad785-54e1-46dd-a412-7a59ac8a3f7f',E'Uganda'),
(E'1e4f0dc2-5da3-4ade-8132-c5ea035fff2e',E'Ukraine'),
(E'108a2ce6-e0af-478a-8015-e64f35753f76',E'United Arab Emirates'),
(E'c2d6f049-7410-400c-950c-d1bf3915dd5a',E'United Kingdom'),
(E'3107a936-9d11-4578-b81a-b2f45521da7d',E'United States'),
(E'fa899168-6e24-44bf-9dcf-e14c7ac879bd',E'Uruguay'),
(E'8de15338-a531-439b-8f90-115f0feae1e7',E'Uzbekistan'),
(E'5260b98c-6e08-46db-8c47-ee7a64a2f47d',E'Vanuatu'),
(E'a833391b-b5d5-438a-b0f9-de3f19ff1def',E'Vatican City'),
(E'87146d34-c509-4a79-a375-0fdb3aab8bca',E'Venezuela'),
(E'22cc7f29-d3fd-45f8-8c05-2e1e31aa7786',E'Vietnam'),
(E'994ab03e-abc7-497c-82b4-62fca1159ad0',E'Yemen'),
(E'0e5768e1-113b-4166-806c-26e728b6ac84',E'Zambia'),
(E'd3e8d4e4-9659-4f5c-ba16-5bb17bdcefe1',E'Zimbabwe');

INSERT INTO "public"."city"("id","name","country_id")
VALUES
(E'0fede1a2-de3f-42d1-ae66-b426b9016721',E'London',E'c2d6f049-7410-400c-950c-d1bf3915dd5a'),
(E'16be4e3b-a034-4477-979a-f5bf4305467b',E'Brussels',E'c25d9c35-8fa8-41b7-b6fb-c5579897942d'),
(E'34e9d955-e46c-4600-8bc8-242b1f462ff9',E'Berlin',E'aedeb663-eeba-4188-88eb-0e1a735df31d'),
(E'96d94315-5717-459e-becf-64a715859da0',E'Charleroi',E'c25d9c35-8fa8-41b7-b6fb-c5579897942d'),
(E'cf729336-07b8-4dee-b991-3090302b7c61',E'Paris',E'77109387-d87c-4d84-ac2a-7b0f4d2dc3f4'),
(E'd318e559-f661-41b6-8959-ad6c1e9b4393',E'Amsterdam',E'00d9105e-5577-4b35-883e-2c46fdf083e2');

INSERT INTO "public"."location"("id","name","city_id","latitude","longitude")
VALUES
(E'6a0a5222-c9fe-490f-b0cc-70f9114ffea9',E'Brussels South Airport',E'96d94315-5717-459e-becf-64a715859da0',E'50.462460',E'4.458815'),
(E'748306bf-fb31-4fcf-ba35-735440b18d1e',E'Paris Charles de Gaulle Airport',E'cf729336-07b8-4dee-b991-3090302b7c61',E'49.009633',E'2.547951'),
(E'99906e1f-1765-4388-a2e8-91e307ce84af',E'Heathrow Airport',E'0fede1a2-de3f-42d1-ae66-b426b9016721',E'51.47011',E'-0.45392'),
(E'b057419b-f36e-44f5-9a28-d2146d1317b0',E'Berlin Brandenburg Airport Willy Brandt',E'34e9d955-e46c-4600-8bc8-242b1f462ff9',E'52.36434',E'13.51061'),
(E'c6ff4bfe-2bb6-4382-a17e-043cdb916d47',E'Amsterdam Airport Schiphol',E'd318e559-f661-41b6-8959-ad6c1e9b4393',E'52.309835',E'4.762879'),
(E'dc672681-9fa2-477d-b5fd-dc7544582975',E'Brussels Airport',E'16be4e3b-a034-4477-979a-f5bf4305467b',E'50.900858',E'4.485482'),
(E'f0ea936f-519a-4215-b613-ac7b33a1179c',E'EPHEC Woluwé',E'16be4e3b-a034-4477-979a-f5bf4305467b',E'50.849823',E'4.449186');

INSERT INTO "public"."client"("id","first_name","last_name","phone_number","email_address","auth0_id")
VALUES
(E'6806ef20-0493-4bf8-b364-747b82b05102',E'Gianluca',E'Lucchesi',E'0470540546',E'PSR10690@students.ephec.be',E'auth0|61c98b07d27de7006abb1427'),
(E'68ef6d42-5976-4a55-998e-f0a3f92486c2',E'Peter',E'Pan',E'0470123456',E'peter-pan@hotmail.com',E'auth0|61e846738006ea006a09d088');

INSERT INTO "public"."reservation_option"("id","name","description","day_price_euro_excl_vat")
VALUES
(E'29ed1e6d-e4e8-427c-b215-20a4cb2c2ca8',E'Insurance',E'No financial responsibility for damage and theft to the rental vehicle',36),
(E'73fb1c0c-79ee-4261-8920-813fa1f5b80b',E'Child Seat',NULL,14),
(E'837be53d-d6bd-41ee-89c5-d2e82d6829e2',E'Charge Card',E'Charge everywhere without limit and without supplement',20),
(E'8faab8e0-bfe3-4faa-9934-650da24d6297',E'Additional Driver',NULL,12);

INSERT INTO "public"."reservation"("id","client_id","car_id","location_id","date_time_start","date_time_stop","total_price_euro_excl_vat")
VALUES
(E'151f04b3-bed5-476f-8e5c-19d241b321e0',E'6806ef20-0493-4bf8-b364-747b82b05102',E'cea78627-d6ea-4a6c-b419-dcc7a3b64d9f',E'dc672681-9fa2-477d-b5fd-dc7544582975',E'2022-01-26 00:00:00',E'2022-01-31 00:00:00',1068),
(E'7d90b25b-318f-4cd7-86a6-c4bc85fa58f8',E'6806ef20-0493-4bf8-b364-747b82b05102',E'c0736218-d84d-4b67-ac32-04a671387719',E'dc672681-9fa2-477d-b5fd-dc7544582975',E'2022-01-26 00:00:00',E'2022-01-29 00:00:00',552),
(E'b0378333-9ae5-4900-8d55-a4c134fcb3c3',E'6806ef20-0493-4bf8-b364-747b82b05102',E'c4e937e3-252a-4b69-b671-e2b4135eb633',E'dc672681-9fa2-477d-b5fd-dc7544582975',E'2022-01-26 00:00:00',E'2022-01-30 00:00:00',625);

INSERT INTO "public"."reservation_reservation_option"("reservation_id","reservation_option_id")
VALUES
(E'151f04b3-bed5-476f-8e5c-19d241b321e0',E'29ed1e6d-e4e8-427c-b215-20a4cb2c2ca8'),
(E'b0378333-9ae5-4900-8d55-a4c134fcb3c3',E'8faab8e0-bfe3-4faa-9934-650da24d6297'),
(E'7d90b25b-318f-4cd7-86a6-c4bc85fa58f8',E'837be53d-d6bd-41ee-89c5-d2e82d6829e2'),
(E'7d90b25b-318f-4cd7-86a6-c4bc85fa58f8',E'8faab8e0-bfe3-4faa-9934-650da24d6297'),
(E'b0378333-9ae5-4900-8d55-a4c134fcb3c3',E'29ed1e6d-e4e8-427c-b215-20a4cb2c2ca8'),
(E'b0378333-9ae5-4900-8d55-a4c134fcb3c3',E'73fb1c0c-79ee-4261-8920-813fa1f5b80b'),
(E'7d90b25b-318f-4cd7-86a6-c4bc85fa58f8',E'73fb1c0c-79ee-4261-8920-813fa1f5b80b'),
(E'b0378333-9ae5-4900-8d55-a4c134fcb3c3',E'837be53d-d6bd-41ee-89c5-d2e82d6829e2'),
(E'7d90b25b-318f-4cd7-86a6-c4bc85fa58f8',E'29ed1e6d-e4e8-427c-b215-20a4cb2c2ca8');