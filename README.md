# Path Drawer

Create a new application, called PathDrawer. It should have the
following classes: SceneViewController (inherits UiViewController),
SceneView (inherits UiView and takes up the full screen), Scene,
PenTool, and PathItem.

SceneView should own a Scene and a PenTool. It should get down, move,
and up touch events and report them to PenTool. When it needs to draw,
it should ask the Scene to do all of the drawing work.

PenTool should have three methods, onDown(x,y), onMove(x,y), and onUp().
These methods should be called by the SceneView when the user presses
his finger down on the screen, moves it to a new location, and then
lifts it respectively. PenTool should have a list of points that starts
out with just one point in onDown() and adds a point each time onMove()
is called. In onUp(), it should convert that list of points into a
PathItem and add the PathItem to the Scene. (Alternatively, it could
construct a PathItem right away and add a point to it each time onMove
is called.) Either way, you should not see any changes until the user
lifts his finger. That is not bad--it is expected.

PathItem should contain a list of points (representing a path) and have
a draw() method that draws a path connecting these points.

Scene keeps track of a collection of PathItems. It should have an
addPathItem() method (called by PenTool) and a draw() method (called by
SceneView). When the SceneView needs to draw, it asks Scene to draw. The
Scene in turn loops through its list of PathItems and asks each one of
those to draw.

Hints: Think about how this project can be split into separate tasks. If
you're stuck, consider adapting the DotViewer app to use this new
framework. The PathItem is just a much more complicated Dot. Consider
starting by redoing your DotViewer app but using the framework above.

