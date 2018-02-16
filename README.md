# NestedChangesetExamples

This is meant to serve as an example of the many ways to address nested data sets in ecto.

I would like to learn the alternative ways to build associated data.

For this I will use the example of a `Contact` having many `Phone numbers`

While the context of a `Contact` having many `Phone numbers` maybe best addressed a different way
(IE: embeds_many ) I think it has the simplest context to highlight the task at hand.

For my first example I will show case a very basic common scenario for people just learning ecto, where I use `cast_assoc` in contacts changeset pipline to bind `phone_numbers`

This is done via the contact's changeset pipeline and only requires that I pass the nested changeset for phone numbers as a list like so.


```
iex(1)> alias NestedChangesetExamples.Accounts
NestedChangesetExamples.Accounts
iex(2)> Accounts.create_contact_with_cast_assoc(%{name: "foo", description: "bar", phone_numbers: [ %{number: "555-5555"}] })
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

It has been expressed by the community that this is not always the most favorable way to create associated data.

This repo is aimed to explore the alternatives.

Heres the example of how you could do with via Ecto.Multi

```
iex(31)> Accounts.create_contact_ecto_multi(%{name: "foo", description: "bar", phone_numbers: [ %{number: "555-5555"}] })
[debug] QUERY OK db=0.4ms
begin []
%NestedChangesetExamples.Accounts.Contact{
  __meta__: #Ecto.Schema.Metadata<:loaded, "contacts">,
  description: "bar",
  id: 27,
  inserted_at: ~N[2018-02-16 17:56:07.014630],
  name: "foo",
  phone_numbers: #Ecto.Association.NotLoaded<association :phone_numbers is not loaded>,
  updated_at: ~N[2018-02-16 17:56:07.014647]
}
[debug] QUERY OK db=1.3ms
INSERT INTO "contacts" ("description","name","inserted_at","updated_at") VALUES ($1,$2,$3,$4) RETURNING "id" ["bar", "foo", {{2018, 2, 16}, {17, 56, 7, 14630}}, {{2018, 2, 16}, {17, 56, 7, 14647}}]
[debug] QUERY OK db=2.0ms
INSERT INTO "contact_phone_numbers" ("number","inserted_at","updated_at") VALUES ($1,$2,$3) RETURNING "id" ["555-5555", {{2018, 2, 16}, {17, 56, 7, 16812}}, {{2018, 2, 16}, {17, 56, 7, 16830}}]
[debug] QUERY OK db=2.2ms
commit []
{:ok,
 %{
   :contact => %NestedChangesetExamples.Accounts.Contact{
     __meta__: #Ecto.Schema.Metadata<:loaded, "contacts">,
     description: "bar",
     id: 27,
     inserted_at: ~N[2018-02-16 17:56:07.014630],
     name: "foo",
     phone_numbers: #Ecto.Association.NotLoaded<association :phone_numbers is not loaded>,
     updated_at: ~N[2018-02-16 17:56:07.014647]
   },
   {:phone_numer, 0} => %NestedChangesetExamples.Accounts.Contact.PhoneNumber{
     __meta__: #Ecto.Schema.Metadata<:loaded, "contact_phone_numbers">,
     contact: #Ecto.Association.NotLoaded<association :contact is not loaded>,
     contact_id: nil,
     id: 7,
     inserted_at: ~N[2018-02-16 17:56:07.016812],
     number: "555-5555",
     updated_at: ~N[2018-02-16 17:56:07.016830]
   }
 }}
iex(32)>
```


Feel free to contribute your way of dealing with this simple task and submit a PR and I will add it to show case.
