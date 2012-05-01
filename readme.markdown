CSLinearLayoutView
=============

CSLinearLayoutView is designed to simplify relative layouts in iOS. We've all been there before -- you're app needs to display content of varying size, and you want to display views in neat succession. You spend the next few hours pushing pixels, estimating text sizes, and tracking deltas. Lame.

Enter CSLinearLayoutView. Create your layout view, create items from your views, add the items to your layout. Much simpler.

Example Usage
---------
	// create the linear layout view
	CSLinearLayoutView *linearLayoutView = [[[CSLinearLayoutView alloc] initWithFrame:self.view.bounds] autorelease];
    linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    [self.view addSubview:linearLayoutView];

    // create a view
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 50.0)] autorelease];
    view.backgroundColor = [UIColor redColor];
    
    // create a layout item with the view
     CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:view];
    item.padding = CSLinearLayoutMakePadding(5.0, 10.0, 5.0, 10.0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    item.fillMode = CSLinearLayoutItemFillModeNormal;
    
    // add the layout item to the linear layout view
    [linearLayoutView addItem:item];

MIT License
-----------
    Copyright (c) 2012 Charles Scalesse.

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.