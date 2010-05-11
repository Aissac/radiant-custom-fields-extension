Radiant Custom Fields Extension
===

About
---

An extension by [Aissac][ai] that allows you to add custom fields to [Radiant CMS][rd] pages.

Tested on Radiant 0.7.1, 0.8 and 0.9 RC2.

Checkout the [screencast][rc]!

Features
---

* Provides the ability to add custom fields to a Page;
* The Page model is not changed: custom\_fields are added as a belongs\_to association;
* Admin interface for managing assigned custom fields;
* Radius tags for accessing custom fields.

Important Notice!
---

The git branches of this repository hold stable versions of the extension for older versions of Radiant CMS. For example the _0.8_ branch is compatible with Radiant 0.8. 

To checkout one of these branches:

    git clone git://github.com/Aissac/radiant-custom-fields-extension.git vendor/extensions/custom_fields
    cd vendor/extensions/custom_fields
    git checkout -b <branch-name> origin/<remote-branch-name>

As an example, if you're working on Radiant 0.8 you will need to checkout the 0.8 branch:
    
    cd vendor/extensions/custom_fields
    git checkout -b my_branch origin/0.8

Installation
---

The [Custom Fields Extension][cfe] has no dependencies, so all you have to do is install it:
  
  	git clone git://github.com/Aissac/radiant-custom-fields-extension.git vendor/extensions/custom_fields

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

* Cristi Duma ([@cristi_duma][cd])
* Istvan Hoka ([@ihoka][ih])

TODO
---
* AJAX-ify admin interface.


[ai]: http://www.aissac.ro/
[rd]: http://radiantcms.org/
[cfe]: http://github.com/Aissac/radiant-custom-fields-extension/
[cd]: http://twitter.com/cristi_duma
[ih]: http://twitter.com/ihoka
[rc]: http://radiantcms.org/blog/archives/2010/03/23/radiantcasts-episode-6-radiant-custom-fields-and-stereotype-extensions/