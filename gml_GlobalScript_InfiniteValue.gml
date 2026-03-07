/*
DECOMPILER FAILED!

Underanalyzer.Decompiler.DecompilerException: Unexpected exception thrown in decompiler during AST building: Stack empty.
 ---> System.InvalidOperationException: Stack empty.
   at System.Collections.Generic.Stack`1.ThrowForEmptyStack()
   at Underanalyzer.Decompiler.AST.BlockSimulator.SimulateNew(ASTBuilder builder, IGMInstruction instr)
   at Underanalyzer.Decompiler.AST.BlockSimulator.SimulateCall(ASTBuilder builder, List`1 output, IGMInstruction instr)
   at Underanalyzer.Decompiler.AST.BlockSimulator.Simulate(ASTBuilder builder, List`1 output, Block block)
   at Underanalyzer.Decompiler.AST.ASTBuilder.BuildBlock(IControlFlowNode startNode)
   at Underanalyzer.Decompiler.AST.IFragmentNode.Create(ASTBuilder builder, Fragment fragment)
   at Underanalyzer.Decompiler.ControlFlow.Fragment.BuildAST(ASTBuilder builder, List`1 output)
   at Underanalyzer.Decompiler.AST.ASTBuilder.BuildBlock(IControlFlowNode startNode)
   at Underanalyzer.Decompiler.AST.IFragmentNode.Create(ASTBuilder builder, Fragment fragment)
   at Underanalyzer.Decompiler.ControlFlow.Fragment.BuildAST(ASTBuilder builder, List`1 output)
   at Underanalyzer.Decompiler.AST.ASTBuilder.Build()
   at Underanalyzer.Decompiler.DecompileContext.DecompileAST()
   --- End of inner exception stack trace ---
   at Underanalyzer.Decompiler.DecompileContext.DecompileAST()
   at Underanalyzer.Decompiler.DecompileContext.DecompileToString()
   at Submission#0.DumpCode(UndertaleCode code) in G:\桌面备份\UndertaleModTool_v0.8.3.0-Windows\Scripts\Resource Exporters\ExportAllCode.csx:line 48
*/