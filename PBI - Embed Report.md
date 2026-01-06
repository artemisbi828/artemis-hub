Need Publish to Web in order to be a non-tenant user
`Tenant Settings` → `Publish to web` → (toggle) `Allow users to create new embed codes` 


**Challenge:** Power BI iframe remained narrow despite increasing `max-width` values—Docusaurus container constraints limited width expansion.

**Solution:** Changed `.container` from `max-width: 1680px` to `width: 95vw; max-width: none;` to use viewport-based sizing and bypass default theme constraints.

**Key:** Viewport width units (`vw`) override theme container limits; `max-width: none` removes the ceiling.