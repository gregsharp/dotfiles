def NoInterpolate(caller,event):
  for node in slicer.util.getNodes('*').values():
    if node.IsA('vtkMRMLScalarVolumeDisplayNode'):
      node.SetInterpolate(0)

slicer.mrmlScene.AddObserver(slicer.mrmlScene.NodeAddedEvent, NoInterpolate)

for node in getNodesByClass('vtkMRMLSliceCompositeNode'):
  node.SetLinkedControl(1)

defaultSliceCompositeNode = slicer.vtkMRMLSliceCompositeNode()
defaultSliceCompositeNode.SetLinkedControl(1)
slicer.mrmlScene.AddDefaultNode(defaultSliceCompositeNode)
