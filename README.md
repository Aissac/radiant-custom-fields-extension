Radiant Custom Fields Extension
===

About
---

An extension by [Aissac][ai] that allows you to add custom fields to [Radiant CMS][rd] pages.

Test on Radiant 0.7.1 and 0.8.

Features
---

* Provides the ability to add custom fields to a Page;
* The Page model is not changed: custom\_fields are added as a belongs\_to association;
* Admin interface for managing assigned custom fields;
* Radius tags for accessing custom fields.

Installation
---

The [Custom Fields Extension][cfe] has no dependencies, so all you have to do is install it:
  
  	git submodule add git://github.com/Aissac/radiant-custom-fields-extension.git vendor/extensions/custom_fields

Then run the migration and the update:
  
  	rake radiant:extensions:custom_fields:migrate
  	rake radiant:extensions:custom_fields:update

Usage
---

###Available Tags

* See the "available tags" documentation built into the Radiant page admin for more details.
* Use the `<r:custom_field:value />` tag to render the value of a custom field.
* Use the `<r:custom_field:each />` tag to iterate over the assigned custom fields of a page.
* Use the `<r:custom_fields:if_matches />` and `<r:custom_field:unless_matches>` tags to filter the custom fields.

Contributors
---

* Cristi Duma
* Istan Hoka

TODO
---
* default (fallback) atribute for missing fields;
* AJAX-ify admin interface.


[ai]: http://www.aissac.ro/
[rd]: http://radiantcms.org/
[cfe]: http://github.com/Aissac/radiant-custom-fields-extension/