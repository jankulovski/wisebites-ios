

1. Intro Screen: Stylish “Get Started” button.

2. Auth Screen: Options for OTP, Apple, or Google login. 
    * After login/registration, proceed to subscription selection if a new user.

3. Subscription Screen: Select Free, Standard, or Pro. (mock UI for now).

4. Home Screen:
    * Search bar at top.
    * Horizontal scroll filters (Dinner, Easy, Vegetarian, etc.).
    * Horizontal scroll sections: “Latest Recipes” and dynamic "Collections". Each section has a "View All" button.
    * Floating "+" button bottom-right → options: Capture / Upload / Compose.

5. Capture/Upload Screen:
    * Show photo preview after selection/capture.
    * Select “Dish” or “Ingredients”.
    * Text input for hint.

6. Compose Screen:
    * Manual create recipe with all fields (Name, Ingredients, Instructions, etc.).

7. Recipe Detail Screen:
    * View recipe details.
    * Settings icon to edit/delete.

8. Collection View:
    * View all recipes inside a collection.
    * Settings to edit/delete collection.

9. Profile Screen:
    * Update profile information.
    * Settings (mock for now).
    * Subscription management.

Use native iOS styles as much as possible (Apple fonts, colors, loading indicators, success/error alerts). Set up navigation between all screens.

Structure code cleanly — pages/screens, components, services folders, etc.

Here are the models attributes:

Recipe:
id uuid
user_id uuid
image_url text
name text
ingredients jsonb
instructions jsonb
nutrition jsonb
tips jsonb
tags jsonb
prep_time int
cook_time int
servings int
difficulty_level text
created_at timestamptz
updated_at timestamptz

Collection:
id uuid
user_id uuid
name textcreated_at timestamptz
updated_at timestamptz

Recipe Collection:
id uuid
collection_id uuid
recipe_id uuid
created_at timestamptz

Profile:
id uuid
email text
full_name text
avatar_url text
created_at timestamptz
updated_at timestamptz

In the attachments I’m providing images how the inside app should look like. It’s inspired by Apple News+ Recipe app.

<aesthetics>
Bold simplicity with intuitive navigation creating frictionless experiences.
Breathable whitespace complemented by strategic color accents for visual hierarchy.
Strategic negative space calibrated for cognitive breathing room and content prioritization.
Systematic color theory applied through subtle gradients and purposeful accent placement.
Typography hierarchy utilizing weight variance and proportional scaling for information architecture.
Visual density optimization balancing information availability with cognitive load management.
Motion choreography implementing physics-based transitions for spatial continuity.
Accessibility-driven contrast ratios paired with intuitive navigation patterns ensuring universal usability.
Feedback responsiveness via state transitions communicating system status with minimal latency.
Content-first layouts prioritizing user objectives over decorative elements for tasks efficiency.
</aesthetics>