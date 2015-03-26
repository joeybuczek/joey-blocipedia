## Readme

** Blocipedia - a project by Joey Buczek for bloc apprenticeship **

03/20/15 [In Iceland!]
 - Only wiki owners can add/remove collaborators
 - Standard users see upgrade button in public wikis, premium users do not
 - Fixed issue where users were not being associated with wikis when created (explicitly assigned user in create method). This may be because of has many through relationships

Next step: Scope for premium users to only view private wikis they created or ones they are collaborators on (bloc assignment text)

03/21/15 [In Iceland!]
 - Added scope for viewing wikis, whether they are public, private, or if the user is a collaborator
 - adjusted the pagination gem to work with 'static arrays' instead of just database queries
 
Next step: Fully test the functionality of the site to search for bugs/refactor opportunities before submission