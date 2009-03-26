Radiant Custom Fields Extension
===

About
---

An extension by [Aissac][ai] that allows you to save custom attributes to [Radiant CMS][rd] pages.

The Custom Fields Extension is Radiant 0.7.1 compatible.

Features
---

* Provides the ability to assign custom attributes to a Radiant page;
* Interface for managing assigned custom fields;
* Radius tags for integrating custom_fields functionality into the site;

Installation
---

The [Custom Fields Extension][cfe] has no dependencies, so all you have to do is install it:
  
  git submodule add ..... repository ....

Then run the migration and the update:
  
  rake radiant:extensions:custom_fields:migrate
  rake radiant:extensions:custom_fields:update

Usage
---

#Available Tags

* See the "available tags" documentation built into the Radiant page admin for more details.
* Use the `<r:custom_field:value />` tag to render the value of a custom field.
* Use the `<r:custom_field:each />` tag to iterate over the assigned custom fields of a page.
* Use the `<r:custom_fields:if_matches />` and `<r:custom_field:unless_matches>` tags to filter the custom fields.

Contributors
---

TODO
---


[ai]: http://www.aissac.ro/
[rd]: http://radiantcms.org/
[cfe]: http://github.com/