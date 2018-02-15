# NestedChangesetExamples

This is meant to serve as an example of the meany ways to address nested data sets in ecto.

I would like to learn the alternative ways to build associated data.

While the context of a `Contact` having many `Phone numbers` maybe best addressed a different way
(IE: embeds_many ) I think it has the simplest context to highlight the task at hand.

For my first example I will show case a very basic common scenario for people just learning ecto, where I use `cast_assoc` in contacts to bind `phone_numbers`

This is done at the contact's changeset pipeline and only requires that I pass the nested changeset for phone numbers as a list like so.


```
iex(1)> alias NestedChangesetExamples.Accounts
NestedChangesetExamples.Accounts
iex(2)> Accounts.create_contact(%{name: "foo", description: "bar", phone_numbers: [ %{number: "555-5555"}] })
[debug] QUERY OK db=0.2ms
begin []
[debug] QUERY OK db=3.8ms
INSERT INTO "contacts" ("description","name","inserted_at","updated_at") VALUES ($1,$2,$3,$4) RETURNING "id" ["bar", "foo", {{2018, 2, 15}, {19, 12, 30, 75583}}, {{2018, 2, 15}, {19, 12, 30, 78413}}]
[debug] QUERY OK db=2.1ms
INSERT INTO "contact_phone_numbers" ("contact_id","number","inserted_at","updated_at") VALUES ($1,$2,$3,$4) RETURNING "id" [3, "555-5555", {{2018, 2, 15}, {19, 12, 30, 97738}}, {{2018, 2, 15}, {19, 12, 30, 97747}}]
[debug] QUERY OK db=2.0ms
commit []
{:ok,
 %NestedChangesetExamples.Accounts.Contact{
   __meta__: #Ecto.Schema.Metadata<:loaded, "contacts">,
   description: "bar",
   id: 3,
   inserted_at: ~N[2018-02-15 19:12:30.075583],
   name: "foo",
   phone_numbers: [
     %NestedChangesetExamples.Accounts.Contact.PhoneNumber{
       __meta__: #Ecto.Schema.Metadata<:loaded, "contact_phone_numbers">,
       contact: #Ecto.Association.NotLoaded<association :contact is not loaded>,
       contact_id: 3,
       id: 3,
       inserted_at: ~N[2018-02-15 19:12:30.097738],
       number: "555-5555",
       updated_at: ~N[2018-02-15 19:12:30.097747]
     }
   ],
   updated_at: ~N[2018-02-15 19:12:30.078413]
 }}
```
